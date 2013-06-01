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
      
      it "displays the title, authors, affiliations, poster number, and session info for each abstract" do
        visit abstracts_url
        expect(page).to have_content(@attendee.abstract.title)
        expect(page).to have_content(@attendee.abstract.authors)
        expect(page).to have_content(@attendee.abstract.affiliations)
        expect(page).to have_content(@attendee.abstract.poster_number) unless @attendee.abstract.session.include?('Oral')
        expect(page).to have_content(@attendee.abstract.session)
      end
    end
  end
end
