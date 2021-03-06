require 'spec_helper'

describe Abstract do
  before { @abstract = FactoryGirl.create(:abstract, attendee: FactoryGirl.create(:attendee)) }
  it 'is valid with a title, list of authors, affiliations, body, and associated Attendee' do
    expect(@abstract).to be_valid
  end

  %w{ title authors affiliations body attendee }.each do |m|    
    it "is invalid without a #{m}" do
      @abstract.send("#{m}=".to_sym, nil)
      expect(@abstract).to have(1).errors_on(m.to_sym)
      expect(@abstract).to be_invalid
    end
  end
  
  
  describe "email confirmation" do
    context "created abstract" do
      before do
        @attendee = FactoryGirl.create(:attendee)
        @abstract = @attendee.abstracts.create FactoryGirl.attributes_for(:abstract)
      end
      
      it 'should be delivered when a new abstract is created' do
        last_email.to.should include(@attendee.email)
      end

      it 'should verify the contents of the abstract' do
        %w{name email}.each do |m|
          last_email.body.should include("#{m.capitalize}: #{@abstract.attendee.send(m)}")
        end
        
        %w{title authors affiliations body}.each do |m|
          last_email.body.should include("#{m.capitalize}: #{@abstract.send(m)}")
        end
        
        last_email.body.should include("Keywords: #{@abstract.keyword_list}")       
      end     
    end # context
    
    context "updated abstract" do
      before do
        @attendee = FactoryGirl.create(:attendee)
        @abstract = @attendee.abstracts.create FactoryGirl.attributes_for(:abstract)
        @abstract.update_attribute(:title, "Updated abstract subject")
      end
      
      it 'should send a confirmation email with a custom subject when an abstract is updated' do
        last_email.to.should include(@attendee.email)
        last_email.subject.should include("received your abstract update")
      end
      
      it 'should verify the contents of the abstract' do
        %w{name email}.each do |m|
          last_email.body.should include("#{m.capitalize}: #{@abstract.attendee.send(m)}")
        end
        
        %w{title authors affiliations body}.each do |m|
          last_email.body.should include("#{m.capitalize}: #{@abstract.send(m)}")
        end
        
        last_email.body.should include("Keywords: #{@abstract.keyword_list}")       
      end     

      it 'should verify the contents of the abstract' do
        %w{name email}.each do |m|
          last_email.body.should include("#{m.capitalize}: #{@abstract.attendee.send(m)}")
        end
        
        %w{title authors affiliations body}.each do |m|
          last_email.body.should include("#{m.capitalize}: #{@abstract.send(m)}")
        end
        
        last_email.body.should include("Keywords: #{@abstract.keyword_list}")       
      end     
      
    end # context
  end # describe "email confirmation"
end # Abstract
