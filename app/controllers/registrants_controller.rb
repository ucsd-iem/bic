class RegistrantsController < ApplicationController
  before_filter :check_date
  
  protected
  
  def check_date
    redirect_to(root_url, notice: 'Sorry, registration is now closed. Please check back in about two years.') if Time.now > Date.new(2013,11,26)
  end
end
