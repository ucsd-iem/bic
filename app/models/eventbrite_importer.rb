class EventbriteImporter
    
  class << self
    def client
      @client || init_client
    end

    def auth_tokens
      self.const_get :EVENTBRITE_AUTH_TOKENS
    end
    
    def import_attendees
      attendees
      attendees.map {|a| create_or_update_attendee a['attendee']}
    end
    
    def import_tickets
      attendees
      attendees.map {|a| create_or_update_tickets a['attendee']}
    end
    
    def attendees
      self.client.event_list_attendees(:id => '5146078058')['attendees']
    end
    
    private

    def create_or_update_attendee(attendee)
      attributes_hash = slice_attributes(attendee, %w(first_name last_name email))

      result = Attendee.find_by_email(attendee['email'])
      unless result
        attributes_hash['password'] = attendee['order_id']
        result = Attendee.create(attributes_hash)
      end
      
      result
    end
  
    def create_or_update_tickets(attendee)
      attributes_hash = slice_attributes(attendee, %w(barcode currency ebrite_id ebrite_order_id quantity ebrite_ticket_id ebrite_event_id))

      unless ticket = Ticket.find_by_barcode(attributes_hash['barcode']) && ticket
        # create ticket
        # make sure attendees exist in DB to 
        db_attendee = create_or_update_attendee(attendee)      

        ticket = db_attendee.tickets.create(attributes_hash)
      end

      ticket.valid? ? ticket : ticket.errors      
    end  

    def slice_attributes(attributes, selected_attributes)
      attributes_hash = attributes.slice *selected_attributes
      attributes_hash['ebrite_id'] = attributes['id'] if selected_attributes.include?('ebrite_id')
      attributes_hash['ebrite_event_id'] = attributes['event_id'] if selected_attributes.include?('ebrite_event_id')
      attributes_hash['ebrite_order_id'] = attributes['order_id'] if selected_attributes.include?('ebrite_order_id')
      attributes_hash['ebrite_ticket_id'] = attributes['ticket_id'] if selected_attributes.include?('ebrite_ticket_id')
      
      attributes_hash
    end
    
    def init_client
      @client = EventbriteClient.new(self.auth_tokens)
    end    
  end # end class << self
end

