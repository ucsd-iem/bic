require 'spec_helper'

describe Attendee do
  # object instantiation
  it { should be_an_instance_of(Attendee) }

  # association(s)
  it { should respond_to :tickets }
  it { should have_many :tickets }
  
  it 'should return the combination of firstname / lastname when called with .name' do
    attendee = FactoryGirl.create(:attendee)
    attendee.name.should == "#{attendee.first_name} #{attendee.last_name}"
  end
  
  describe '.abstract' do
    before { @attendee = FactoryGirl.create(:attendee) }
    
    it 'should return nil when the attendee has no abstracts' do
      @attendee.abstract.should be nil
    end
    
    it 'should return the first abstact chronologically with one or more abstracts' do
      3.times { @attendee.abstracts.create FactoryGirl.attributes_for(:abstract) }
      abstract = @attendee.abstracts.create FactoryGirl.attributes_for(:abstract)
      @attendee.abstracts << abstract
      @attendee.should have(4).abstracts
      @attendee.abstract.should eq abstract
    end
  end
end