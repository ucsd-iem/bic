class Attendee < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  before_save :ensure_authentication_token
  
  class << self
    
    attr_reader :cache_freq
    attr_accessor :last_attendees_request
        
    def create_or_update
      
    end
    
    def import
      ec = init_client

      puts time_since_last_attendees_request
      puts @cache_freq

      if time_since_last_attendees_request > @cache_freq
        @last_attendees_request = Time.now
        
        @attendees = ec.event_list_attendees(:id => '5146078058')['attendees']
        @attendees.map {|a| create_or_update a['attendee']}

      else
        @attendees
      end
    end

    private
  
    def init_client
      @cache_freq = 3.0
      EventbriteClient.new(EVENTBRITE_AUTH_TOKENS)
    end
  
    def time_since_last_attendees_request
      @last_attendees_request.nil? ? @cache_freq+0.1 : Time.now - @last_attendees_request
    end
    
    def create_or_update(attendee)
      result = Attendee.find_by_eid(attendee['id'].to_s)
      if result
        result.update_attributes( :eid => attendee['id'],
          :first_name => attendee['first_name'], 
          :last_name => attendee['last_name'],
          :email => attendee['email'],
          :order_type => attendee['order_type'],
          :barcode => attendee['barcode'].to_s,
          :order_id => attendee['order_id'],
          :amount_paid => attendee['ammount_paid'],
          :currency => attendee['currency'],
          :discount => attendee['discount'],
          :quantity => attendee['quantity'].to_i,
          :ticket_id => attendee['ticket_id'].to_i,
          :event_id => attendee['event_id'].to_i,
          :event_date => attendee['event_date'],
          :created => attendee['created'],
          :modified => attendee['modified']
        )        
      else
        create( :eid => attendee['id'],
          :first_name => attendee['first_name'], 
          :last_name => attendee['last_name'],
          :email => attendee['email'],
          :order_type => attendee['order_type'],
          :barcode => attendee['barcode'].to_s,
          :order_id => attendee['order_id'],
          :amount_paid => attendee['ammount_paid'],
          :currency => attendee['currency'],
          :discount => attendee['discount'],
          :quantity => attendee['quantity'].to_i,
          :ticket_id => attendee['ticket_id'].to_i,
          :event_id => attendee['event_id'].to_i,
          :event_date => attendee['event_date'],
          :created => attendee['created'],
          :modified => attendee['modified']
        )
      end
      
      result != false
    
      
    end
  end # end class << self
  
  attr_accessible :amount_paid, :barcode, :created, :currency, :discount, :eid, :email, :event_date, :event_id, :first_name, :last_name, :modified, :order_id, :order_type, :quantity, :ticket_id
  devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable, :lockable, :timeoutable
  
  has_one :abstract, :class_name => "Abstract"

  validates_presence_of :email
  validates_presence_of :first_name
  validates_presence_of :last_name
  validates_uniqueness_of :eid

  def name
    @name = ""
    @name += "#{self.first_name} #{self.last_name}"
  end
    
end
