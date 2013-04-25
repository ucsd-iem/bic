class PagesController < ApplicationController
  after_filter :import_new_tickets, only: :thanks
  layout 'sponsors', :only => [:sponsors]
  
  def home
    @announcements = Announcement.all
  end

  def thanks
  end
  
  private
  
  def import_new_tickets
    logger.info  "Importing attendee data from Eventbrite."
    EventbriteImporter.import_tickets
  end
end
