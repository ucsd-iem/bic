class PagesController < ApplicationController
  
  layout 'sponsors', :only => [:sponsors]
  
  def home
    @announcements = Announcement.all
  end

  def thanks
    #logger.info  "Importing attendee data from Eventbrite."
    #EventbriteImporter.import_tickets    
  end
end
