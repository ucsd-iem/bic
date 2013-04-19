require 'spec_helper'

describe "Pages" do
  describe "GET /" do
    before { visit root_url; page.status_code.should be(200) }
    it "should display the welcome message" do
      page.should have_content("Welcome")
    end
    it "should display a message regarding the current registration deadline in a span.alert-error" do
      page.text.should match /\w+ \d+/
    end
    
    
    describe 'announcements' do
      it "should display a filler message when there are no announcements" do
        page.should have_content('No announcements yet.')
      end

      it "should display the announcement title and body when there are announcements" do
        announcement = FactoryGirl.create(:announcement)
        visit root_url
        page.should have_content(announcement.title)
        page.should have_content(announcement.body)
      end
    end
  end

  describe "GET /location" do
    it "should include the name of the main event location and an embedded googlemap" do
      visit location_url
      page.status_code.should be(200)
      page.should have_content("Price Center & Center Hall")
      #page.should have_content("<iframe width=\"590\" height=\"590\" frameborder=\"0\" scrolling=\"no\" marginheight=\"0\" marginwidth=\"0\" src=\"https://maps.google.com/maps/ms?msa=0&amp;msid=217723166706845739193.0004cba4e7b1c1cef1ada&amp;ie=UTF8&amp;t=m&amp;ll=32.882524,-117.234721")
    end
  end

  describe "GET /accommodations" do
    it "should include sections for 'Accomodations' and 'Hotels'" do
      visit accommodations_url
      page.status_code.should be(200)
      page.should have_content("Accomodations")      
      page.should have_content("Hotels")      
    end
  end

  describe "GET /register" do
    it "should contain an iframe from eventbrite" do
      visit register_url
      page.status_code.should be(200)
      page.should have_content("Event Registration")      
      #page.should have_content('<iframe src="http://www.eventbrite.com/tickets-external?')      
    end
  end

  describe "GET /contact" do
    it "should display the email and phone number for the event contacts" do
      visit contact_url
      page.status_code.should be(200)
      page.should have_content('bic@ucop.edu')
      page.should have_content('858.534.6265')
    end
  end

  describe "GET /sponsors" do
    it "should display all sponsor logos, taglines, and mission statements (in js box)" do
      sponsor = FactoryGirl.create(:sponsor)

      visit sponsors_url
      page.status_code.should be(200)
      page.should have_content('Sponsors')
      debugger unless page.should have_content(sponsor.mission_statement.truncate(40, :omission => ''))
    end
  end

  describe "GET /thanks" do
    it "works! (now write some real specs)" do
      visit thanks_url
      page.status_code.should be(200)
      page.should have_content('Thanks')
    end
  end

end
