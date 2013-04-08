require 'spec_helper'

describe ApplicationController do
  controller do
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
    end # after_sign_in_path_for
    
    # Overwrite the sign_out redirect path
    def after_sign_out_path_for(resource_or_scope)
      root_path
    end

    def load_sponsors
      @dinner_sponsors = Sponsor.dinner
      @foundational = Sponsor.foundational
      @supporting = Sponsor.supporting
    end
    
  end # controller
  
  before (:each) do
    @attendee = FactoryGirl.create(:attendee)
    @user = FactoryGirl.create(:user)
  end
  
  describe "devise private method overrides for Attendee resource" do
    describe '#after_sign_in_path_for' do
      it "should redirect to the attendee's last abstract edit form with multiple abstracts" do
        pending #ApplicationController.after_sign_in_path_for(Attendee)
      end

      it "should redirect to the attendee's last abstract edit form with one abstract" do

      end

      it "should redirect to a new abstract form with 0 abstracts" do
        stub(:current_attendee)
        controller.after_sign_in_path_for(Attendee).should == '/'
      end

      it "should revert to the standard devise method for all other resources" do
        controller.after_sign_in_path_for(@user).should == '/'
      end
    end
    
    describe '#after_sign_out_path_for' do
      it 'should redirect all users to the home page after signing out' do
        pending
      end
    end
  end  
end # Abstract