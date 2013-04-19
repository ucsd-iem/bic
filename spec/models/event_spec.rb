require 'spec_helper'

describe Event do
  # object instantiation
  it { should be_an_instance_of(Event) }

  # association(s)
#  it { should respond_to :abstracts }
#  it { should have_many :abstracts }
  
  it 'should return a custom name made up of the id, title, and startime' do
    event = FactoryGirl.create(:event)
    event.name.should eq "#{event.id} - #{event.title} - #{event.start}"
  end
  
  describe '.duration' do
    before { @event = FactoryGirl.create(:event) }
    
    it 'should return 0 when the event starts and stops at the same time' do
      @event.start = @event.stop = Time.now
      @event.duration.should eq 0
    end
    
    it 'should return the duration of the event in seconds' do
      @event.start = Time.now
      @event.stop = @event.start + 777.seconds
      @event.duration.should eq 777
    end
  end

  describe '.dynamic_title' do
    it 'should return the plain title unless we bring back session moderators' do
      event = FactoryGirl.create(:event)
      event.dynamic_title.should eq event.title
    end
  end
  
  describe '.list_data(time)' do
    it 'should return html for the event given a time' do
      event = FactoryGirl.create(:event)
      event.list_data(event.start).should include(event.title)
    end
  end
  
  describe '.title_row?(time)' do
    it 'should return true if it is a title row for an event cell' do
      event = FactoryGirl.create(:event)
      event.title_row?(event.start).should be true      
      event.normal_row?(event.start).should be false
    end
  end

  describe '.normal_row?(time)' do
    it 'should return true if it is a normal part of an event cell' do
      event = FactoryGirl.create(:event)
      event.normal_row?(event.stop).should be true      
      event.title_row?(event.stop).should be false
    end
  end

  describe '.end_row?(time)' do
    it 'should return true if it is the end of an event cell' do
      event = FactoryGirl.create(:event)
      event.end_row?(event.stop - 1800).should be true
      event.end_row?(event.stop - 900).should be true
      event.end_row?(event.stop + 900).should be true
      event.end_row?(event.stop).should be false
      event.end_row?(event.stop + 1.year).should be false
      event.title_row?(event.stop).should be false
    end
  end

  describe '.quarter_start?(time)' do
    before { @event = FactoryGirl.create(:event, :start => DateTime.new(2013,6,19,12,15)) }
    it 'should return true if it is a title row and it starts 15m after the hour' do
      @event.quarter_start?(@event.start).should be true
    end
  end

  describe '.quarter_before_start?(time)' do
    before { @event = FactoryGirl.create(:event, :start => DateTime.new(2013,6,21,12,45)) }
    it 'should return true if it is a title row and it starts 45m after the hour' do
      @event.quarter_before_start?(@event.start).should be true      
    end
  end

  describe '.quarter_end?(time)' do
    before { @event = FactoryGirl.create(:event, :start => DateTime.new(2013,6,19,12,00), :stop => DateTime.new(2013,6,19,12,15)) }
    it 'should return true if it is a title_row and it starts 15m after the hour' do
      @event.quarter_end?(@event.stop).should be true      
    end

    it 'should return true if it is a title_row and it stops 45m after the hour' do
      @event.update_attributes :start => DateTime.new(2013,6,19,12,30), :stop => DateTime.new(2013,6,19,12,45)
      @event.quarter_end?(@event.stop).should be true      
    end
  end

  describe '.list_row(time)' do
    context 'with one event' do
      before { @event = FactoryGirl.create(:event, :start => DateTime.new(2013,6,19,12,00), :stop => DateTime.new(2013,6,19,12,15)) }
      it 'should return html for the row of events for a given time' do
        html = Event.list_row(@event.start)
        html.should include(@event.title)
      end
    end

    context 'with multiple events' do
      before do
        @event1 = FactoryGirl.create(:event, :start => DateTime.new(2013,6,19,12,00), :stop => DateTime.new(2013,6,19,12,15))
        @event2 = FactoryGirl.create(:event, :start => DateTime.new(2013,6,19,12,00), :stop => DateTime.new(2013,6,19,12,15))
      end

      it 'should return html for the row of events for a given time' do      
        html = Event.list_row(@event1.start)
        html.should include(@event1.title)
        html.should include(@event2.title)
      end  
    end
  end
end