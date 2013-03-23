class Ticket < ActiveRecord::Base
  attr_accessible :amount_paid, :attendee_id, :barcode, :currency, :ebrite_id, :ebrite_event_id, :ebrite_order_id, :quantity, :ebrite_ticket_id
  
  belongs_to :attendee, :class_name => "Attendee"
  
  validates_presence_of [ :attendee_id, :barcode, :ebrite_id, :ebrite_event_id, :ebrite_order_id, :quantity, :ebrite_ticket_id ]
  validates_uniqueness_of :barcode
  
end
