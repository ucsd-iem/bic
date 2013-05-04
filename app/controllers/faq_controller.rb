class FaqController < ApplicationController
  
  def index
    @faqs = Faq.all
  end

  def search
    @faqs = Faq.all
  end
end
