require 'spec_helper'

describe 'PagesHelper' do
  describe '#tagline_truncated_mission_statement' do
    it "should return a truncated version of the mission statement when sponsor.tagline is blank" do
      sponsor = stub("Sponsor", :tagline => nil, :mission_statement => Faker::Lorem.sentences(rand(3)+1).join('. '))
      content = helper.tagline_truncated_mission_statement(sponsor)
      content.should eq sponsor.mission_statement.truncate(96, :separator => " ")
    end
    
    it "should return sponsor.tagline when it exists" do
      sponsor = stub("Sponsor", :tagline => Faker::Lorem.sentences(rand(2)+1).join('. '), :mission_statement => Faker::Lorem.sentences(rand(4)+1).join('. '))
      content = helper.tagline_truncated_mission_statement(sponsor)
      content.should eq sponsor.tagline      
    end
  end
end