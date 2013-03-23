class Ticket < ActiveRecord::Base
  attr_accessible :amount_paid, :attendee_id, :barcode, :currency, :eid, :event_id, :order_id, :quantity, :ticket_id
  
  belongs_to :attendee, :class_name => "Attendee", :foreign_key => "attendee_id"
  
  validates_presence_of [ :attendee_id, :barcode, :eid, :event_id, :order_id, :quantity, :ticket_id ]


  
end
