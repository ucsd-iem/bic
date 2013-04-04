require 'spec_helper'

describe Sponsor do
  before do
    @sponsor = Sponsor.new
  end
  # basic object instantiation
  it { should be_an_instance_of(Sponsor) }

  # it should not be valid by default
  it { should_not be_valid }
  
  it 'should be valid with the required attributes' do
    sponsor = FactoryGirl.create(:sponsor)
  end

  %w{ name url level logo }.each do |m|
    it "should NOT be valid without the required attribute '#{m}'"  do
      sponsor = Sponsor.create(FactoryGirl.attributes_for(:sponsor, m.to_sym => nil))
      sponsor.should_not be_valid
    end
  end
end
