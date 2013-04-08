require 'spec_helper'

describe Event do
  # object instantiation
  it { should be_an_instance_of(Event) }

  # association(s)
  it { should respond_to :abstracts }
  it { should have_many :abstracts }
  
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
end