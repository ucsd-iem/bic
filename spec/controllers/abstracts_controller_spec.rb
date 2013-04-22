require 'spec_helper'

describe AbstractsController do
  context "when attendee is NOT authenticated, or public user" do
    describe "#index (GET /abstracts)" do
      it "returns a list of all abstracts" do
        attendee = FactoryGirl.create(:attendee)
        attendee.abstracts.create FactoryGirl.attributes_for(:abstract)

        get :index
        assigns(:abstracts).should eq(attendee.abstracts)
      end      
    end

    describe "#show (GET /abstracts/1)" do
      it "returns an abstract according to the given id" do
        attendee = FactoryGirl.create(:attendee)
        attendee.abstracts.create FactoryGirl.attributes_for(:abstract)

        get :show, {:id => attendee.abstract.id}
        assigns(:abstract).should eq(attendee.abstract)
      end      
    end
  
    describe "#new (GET /abstracts/new)" do
      it "redirects to abstracts#submit" do
        get :new
        response.should redirect_to new_attendee_session_url
      end      
    end

    describe "#create (POST /abstracts/create)" do
      it "redirects to abstracts#submit" do
        post :create, :abstract => FactoryGirl.attributes_for(:abstract)
        response.should redirect_to new_attendee_session_url
      end      
    end

    describe "#update (PUT /abstracts/update/1)" do
      it "redirects to abstracts#submit" do
        put :update, :id => 1, :abstract => FactoryGirl.attributes_for(:abstract)
        response.should redirect_to new_attendee_session_url
      end      
    end

    describe "#destroy (DELETE /abstracts/1)" do
      it "redirects to abstracts#submit" do
        delete :destroy, :id => 1
        response.should redirect_to new_attendee_session_url
      end      
    end
  
    describe "#keyword (GET /abstracts/keyword)" do
      before do
        @attendee = FactoryGirl.create(:attendee)
        @attendee.abstracts.create FactoryGirl.attributes_for(:abstract)
      end
      
      it 'returns abstracts that match the keyword' do
        get :keyword, keyword: @attendee.abstract.keyword_list.first
        assigns(:abstracts).first.should eql(@attendee.abstracts.first)
      end

      it 'should NOT return abstracts that do NOT match the keyword' do
        get :keyword, keyword: 'supercalifragilisticexpialidocious'
        assigns(:abstracts).should_not eq(@attendee.abstracts)
      end
      
    end
        
    describe "#tag_cloud (private)" do
      before do
        @attendee = FactoryGirl.create(:attendee)
        @attendee.abstracts.create FactoryGirl.attributes_for(:abstract)        
      end
      
      it "returns an array of tags and their associated abstracts" do
        get :index
        assigns(:keywords).map {|t| t.name.parameterize }.sort.should eq(@attendee.abstract.keyword_list.sort)
      end
    end
      
  end
  
  context "when attendee is authenticated" do
    before do
      request.env['devise.mapping'] = Devise.mappings[:attendee]
      @attendee = FactoryGirl.create(:attendee)
      sign_in @attendee
    end
    
    describe "#new (GET /abstracts/new)" do
      it "builds a new abstract object based on the logged in attendee" do
        request.env['devise.mapping'] = Devise.mappings[:attendee]
        @attendee = FactoryGirl.create(:attendee)
        sign_in @attendee
      
        get :new
        assigns(:abstract).attendee.should eq(@attendee)
      end      
    end
       
    describe "#create (POST /abstracts/create)" do
      context "with valid attributes" do
        before { post :create, abstract: FactoryGirl.attributes_for(:abstract) }
        it "creates a new abstract for the attendee" do
          assigns(:abstract).attendee.should eq(@attendee)
        end
        it "redirects to abstracts#show for review" do
          response.should redirect_to abstract_url(@attendee.abstract)
        end
      end

      context "with INVALID attributes" do
        before { post :create, abstract: FactoryGirl.attributes_for(:abstract, title: nil) }
        it "will NOT save the new abstract" do
          assigns(:abstract).should_not be_valid
        end
        it "re-renders abstracts#new" do
          post :create, abstract: FactoryGirl.attributes_for(:abstract, title: nil)
          response.should render_template :new
        end
      end
    end
    
    describe "#edit (GET /abstracts/edit/1)" do
      it "locates the existing abstract" do
        @attendee.abstracts.create FactoryGirl.attributes_for(:abstract)
        
        get :edit, id: @attendee.abstract
        assigns(:abstract).attendee.should eq(@attendee)
      end      
    end
       
    describe "#update (PUT /abstracts/update/1)" do
      before { @attendee.abstracts.create FactoryGirl.attributes_for(:abstract) }
      
      context "with valid attributes" do
        before { put :update, id: @attendee.abstract, abstract: { :title => "hello" } }

        it "locates the existing abstract" do
          assigns(:abstract).should eq(@attendee.abstract)
        end
        it "updates the abstracts attributes" do
          assigns(:abstract).title.should eq('hello')
        end
        it "redirects to abstracts#show for review" do
          response.should redirect_to abstract_url(@attendee.abstract)
        end
      end

      context "with invalid attributes" do
        before { put :update, id: @attendee.abstract, abstract: FactoryGirl.attributes_for(:abstract, title: nil) }
          
        it "locates the existing abstract" do
          assigns(:abstract).should eq(@attendee.abstract)
        end
        it "will NOT update the abstract" do
          assigns(:abstract).title.should_not eq('hello')
        end        
        it "will retain the invalid attribute in the instance variable" do
          assigns(:abstract).title.should be nil
        end        
        it "re-renders abstracts#edit" do
          response.should render_template :edit
        end
      end
    end

    describe "#destroy (DELETE /abstracts/1)" do
      before { @attendee.abstracts.create FactoryGirl.attributes_for(:abstract) }
          
      it "deletes the abstract" do
        expect{ delete :destroy, id: @attendee.abstract }.to change(Abstract,:count).by(-1)
      end
      it "redirects to abstracts#index" do
        delete :destroy, id: @attendee.abstract
        pending
      end
    end
  end

end