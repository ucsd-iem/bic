class ApplicationController < ActionController::Base
  before_filter :load_sponsors
  protect_from_forgery
  
  private
  
  def after_sign_in_path_for(resource)
      if resource.is_a?(Attendee) && current_attendee
        
        case
        when current_attendee.abstracts.count > 1
          # view both abstracts
          edit_abstract_url(current_attendee.abstract)
        when current_attendee.abstracts.count > 0
          # view both abstracts
          edit_abstract_url(current_attendee.abstract)
        else
          new_abstract_url
        end
        
      else
        super 
      end
  end

  # Overwrite the sign_out redirect path
  def after_sign_out_path_for(resource_or_scope)
    root_path
  end
  
  def load_sponsors
    @dinner_sponsors = Sponsor.dinner
    @foundational = Sponsor.foundational
    @supporting = Sponsor.supporting
  end
end
