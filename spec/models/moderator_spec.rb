require 'spec_helper'

describe Moderator do
  # object instantiation
  it { should be_an_instance_of(Moderator) }
  
  it 'should return the combination of firstname / lastname when called with .name' do
    moderator = FactoryGirl.create(:moderator)
    moderator.name.should == "#{moderator.first_name} #{moderator.last_name}"
  end  
end