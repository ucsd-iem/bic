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
  end # controller
  
  before (:each) do
    request.env['devise.mapping'] = Devise.mappings[:attendee]
    @attendee = FactoryGirl.create(:attendee)
    sign_in @attendee

    request.env['devise.mapping'] = Devise.mappings[:user]
    @user = FactoryGirl.create(:user)
    sign_in @user
  end
  
  describe "devise private method overrides for Attendee resource" do
    describe '#after_sign_in_path_for' do
      it "should redirect to the attendee's last abstract edit form with multiple abstracts" do
        pending #ApplicationController.after_sign_in_path_for(Attendee)
      end

      it "should redirect to the attendee's last abstract edit form with one abstract" do
        @attendee.should be_a_kind_of Attendee
        @attendee.abstracts.create FactoryGirl.attributes_for(:abstract)
        controller.after_sign_in_path_for(@attendee).should == edit_abstract_url(@attendee.abstract)
      end

      it "should redirect to a new abstract form with 0 abstracts" do
        @attendee.should be_a_kind_of Attendee
        controller.after_sign_in_path_for(@attendee).should == new_abstract_url
      end

      it "should revert to the standard devise method for all other resources" do
        pending
        current_user = @user
        controller.after_sign_in_path_for(@user).should == '/admin'
      end
    end
    
    describe '#after_sign_out_path_for' do
      it 'should redirect all users to the home page after signing out' do
        controller.after_sign_out_path_for(@user).should eq root_path
      end
    end
  end  
end # Abstract