require 'spec_helper'

describe PagesController do
  describe "load_sponsors" do
    it "should auto load all sponsors in groups by category" do
      get :home
      response.code.should eq "200"
      puts response.body
  #    @dinner_sponsors.should eq Sponsor.dinner
      pending
    end      
  end
end