require 'spec_helper'

describe EventbriteImporter do
  # basic object instantiation
  it { should be_an_instance_of(EventbriteImporter) }

  it 'should initialize the EventbriteImporter::EVENTBRITE_AUTH_TOKENS from the config file' do
    EventbriteImporter::EVENTBRITE_AUTH_TOKENS.should be_a_kind_of Hash
    lambda {EventbriteImporter::EVENTBRITE_AUTH_TOKENS[:app_key]}.should_not raise_error
    lambda {EventbriteImporter::EVENTBRITE_AUTH_TOKENS[:user_key]}.should_not raise_error
  end
  
  it "should be able to initialize an EventbriteClient object (private method)" do
    EventbriteImporter.send('init_client').should be_an_instance_of(EventbriteClient)
  end

  context "with a functional access_key or app/user key combo" do
    before do
      EventbriteImporter.stubs(:auth_tokens).returns(EventbriteImporter::EVENTBRITE_AUTH_TOKENS)
      @client = EventbriteImporter.send('init_client')
    end

    # do I really need to positive controll the eb client in this app?
    it "should NOT raise an error on publc API methods when supplied an access key or app/user key." do
      pending 'do I really need a positive control on the eb client api?'
    # lambda {@client.user_list_events}.should_not raise_error RuntimeError
    end
    
    context 'with event/organizer id' do
      before do
        attendees = YAML.load_file(Rails.root.join('spec/fixtures/feeds/event_list_attendees_response.yml'))
        @client.stubs('event_list_attendees').returns(attendees)
      end
      
      it 'should return an event data given an event id' do 
        event = YAML.load_file(Rails.root.join('spec/fixtures/feeds/event_get_response.yml'))
        @client.stubs('event_get').returns(event)

        event_response = @client.event_get(:id => 5146078058)
        event_response['event'].should be_a_kind_of Hash
      end
    
      it "should return attendee data for an event given an event id" do
        event_response = @client.event_list_attendees(:id => 5146078058)
        event_response['attendees'].should be_a_kind_of Array
      end
    
      it 'should list events of an organizer given an organizer id' do
        events = YAML.load_file(Rails.root.join('spec/fixtures/feeds/organizer_list_events_response.yml'))
        @client.stubs('organizer_list_events').returns(events)

        event_response = @client.organizer_list_events(:id => 3052229084)
        event_response['events'].should be_a_kind_of Array
      end
      
      it "should import or update existing local attendee data" do
        EventbriteImporter.import_attendees
        
        Attendee.count.should be 3
        Attendee.find_by_email('grad_student@gmail.com').should be_an_instance_of Attendee
      end

      it "should only add tickets that do not already exist in the local db" do
        10.times {EventbriteImporter.import_attendees}
        
        Attendee.count.should eq 3
        Attendee.find_by_email('grad_student@gmail.com').should be_an_instance_of Attendee
      end


      it "should import or update existing local ticket data" do
        EventbriteImporter.import_tickets
        
        Ticket.count.should eq 5
        # Attendee.find_by_email('okhandan@gmail.com').should be_an_instance_of Attendee
      end

      it "should only add tickets that do not already exist in the local db" do
        10.times {EventbriteImporter.import_tickets}
        
        Ticket.count.should eq 5
        # Attendee.find_by_email('okhandan@gmail.com').should be_an_instance_of Attendee
      end
      
    end

    # do I really need a negative control on the eb client api?
    context 'withOUT event/organizer id' do
      it 'should error when querying for restricted data' do 
        pending 'do I really need a negative control on the eb client api?'
      #  lambda { @client.event_get }.should raise_error RuntimeError
      end
    
      it "should error when querying attendee data" do
        pending 'do I really need a negative control on the eb client api?'
       # lambda { @client.event_list_attendees }.should raise_error RuntimeError
      end
    
      it 'should error when querying for a list events of an organizer' do
        pending 'do I really need a negative control on the eb client api?'
      #  lambda { @client.organizer_list_events }.should raise_error RuntimeError
      end
    end
  end # end contex

  context "without access (access_key, app/user key, event/organizer id)" do
    before do
      EventbriteImporter.stubs(:auth_tokens).returns(nil)
      @client = EventbriteImporter.send('init_client')
    end    
  end # end context  
end # end describe
