class PagesController < ApplicationController
  
  layout 'sponsors', :only => [:sponsors]
  
  def home
    @announcements = Announcement.all
  end

  def sponsors
    @dinner_sponsors = Sponsor.where(:level => 'Dinner Sponsor').order('name ASC')
    @foundational = Sponsor.where(:level => 'Foundational').order('name ASC')
    @supporting = Sponsor.where(:level => 'Supporting').order('name ASC')
  end

  def thanks
    logger.info  "Importing attendee data from Eventbrite."
    EventbriteImporter.import_tickets
    
    if @registrant_id = request.query_string
      eb_client = EventbriteClient.new(EVENTBRITE_AUTH_TOKENS)
#      @response = eb_client.user_get(@registrant_id)
      @response = eb_client.user_get(@registrant_id)
    else
      redirect_to root_url
    end
    
  end
end
