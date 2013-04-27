require 'spec_helper'

describe FaqController do

  describe "GET 'index'" do
    it "returns a list of all faqs" do
      faq = FactoryGirl.create(:faq)
      get :index
      
      expect(response).to be_success
      expect(assigns(:faqs)).to eq([faq])
    end
  end

  describe "GET 'search'" do
    it "returns a list of faqs whose question or answer matches the search query" do
      pending
      faq = FactoryGirl.create(:faq)
      get :index, q: faq.question

      expect(response).to be_success
      expect(assigns(:faqs)).to eq([faq])
    end
  end

end
