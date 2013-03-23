require 'spec_helper'

module TicketSpecHelper
  def valid_ticket_attributes
    { :attendee_id => 1,
      :barcode => "148106302189258150001",
      :quantity => 1,
      :ebrite_id => 189258150,
      :ebrite_event_id => 5146078058,
      :ebrite_order_id => 148106302,
      :ebrite_ticket_id => 17474148 }
  end
  
  def required_keys
    valid_ticket_attributes.keys
  end
end
include TicketSpecHelper

describe Ticket do  
  include TicketSpecHelper

  # basic object instantiation
  it { should be_an_instance_of(Ticket) }

  # it should not be valid by default
  it { should_not be_valid }

  # test basic association
  it { should belong_to :attendee }

  context "an instance of Ticket" do
    # create a new ticket instance before each test
    before do
      @ticket = Ticket.new
    end

    # instance methods should be readble
    %w(attendee ebrite_id barcode ebrite_order_id quantity ebrite_ticket_id ebrite_event_id created_at updated_at).map { |m| it { @ticket.should respond_to m.to_sym } }  
    
    # instance methods should be writeable
    # string datatypes
    %w(barcode currency).each do |m|
      it "should be writeable for #{m}" do
        @ticket.attributes = {m.to_sym => "a string"}
        @ticket.send(m).should == "a string"
      end
    end
          
    # integer datatypes
    %w(ebrite_id ebrite_order_id quantity ebrite_ticket_id ebrite_event_id).each do |m|
      it "should be writeable for #{m}" do
        @ticket.attributes = {m.to_sym => 714732947382934 }
        @ticket.send(m).should == 714732947382934
      end
    end

    # it should be valid with the required attributes: :attendee_id, :barcode, :eid, :event_id, :order_id, :quantity, :ticket_id
    it "should be valid with the required attributes" do 
      @ticket.attributes = valid_ticket_attributes
      @ticket.should be_valid
    end
    
    # it should be valid with the required attributes: :attendee_id, :barcode, :eid, :event_id, :order_id, :quantity, :ticket_id
    required_keys.each do |m|
      it "should NOT be valid without the required attribute #{m}" do   
        @ticket.attributes = valid_ticket_attributes.except(m)
        @ticket.should_not be_valid
      end
    end
    
  end # end context
  
  
end # end describe