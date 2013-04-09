require 'spec_helper'

describe "Abstracts" do
  describe "GET /abstracts" do
    it "should display a message when no abstracts have been submitted" do
      visit abstracts_url
      page.should have_content('No abstracts')
    end
    context 'with abstracts' do
      before do
        @attendee = FactoryGirl.create(:attendee)
        @attendee.abstracts.create FactoryGirl.attributes_for(:abstract)
      end
      
      it "should include a link to submit an abstract" do
        visit abstracts_url
        page.should have_content(@attendee.abstract.title)
      end
    
      it "should display a message regarding the current registration deadline in a span.alert-error" do
  #      response.body.should match /alert-error.*\w+ \d+.*/
      end
    end
  end
end
