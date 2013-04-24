require 'spec_helper'

describe "Pages" do
  describe "GET /" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get root_url
      response.status.should be(200)
    end
  end

  describe "GET /location" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get location_url
      response.status.should be(200)
    end
  end

  describe "GET /accommodations" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get accommodations_url
      response.status.should be(200)
    end
  end

  describe "GET /register" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get new_registrant_url
      response.status.should be(200)
    end
  end

  describe "GET /contact" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get contact_url
      response.status.should be(200)
    end
  end

  describe "GET /sponsors" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get sponsors_url
      response.status.should be(200)
    end
  end

end
