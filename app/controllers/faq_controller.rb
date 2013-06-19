class FaqController < ApplicationController
  
  def index
    @faqs = Faq.order('position ASC')
  end

  def search
    @faqs = Faq.all
  end
end
