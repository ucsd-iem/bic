require 'spec_helper'

describe EventsController do
  describe "#index (GET /abstracts)" do
    before do
      @wednesday = FactoryGirl.create(:event, :start => DateTime.new(2013,6,19,12), :stop => DateTime.new(2013,6,19,12))
      @thursday = FactoryGirl.create(:event, :start => DateTime.new(2013,6,20,12), :stop => DateTime.new(2013,6,20,12))
      @friday = FactoryGirl.create(:event, :start => DateTime.new(2013,6,21,12), :stop => DateTime.new(2013,6,21,12))
    end

    it "returns a list of all events for the given day in instance variables" do
      get :index
      
      assigns(:wednesday).first.should eq(@wednesday)
      assigns(:thursday).first.should eq(@thursday)
      assigns(:friday).first.should eq(@friday)
    end      
  end
end