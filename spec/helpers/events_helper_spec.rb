require 'spec_helper'

describe 'EventsHelper' do
  describe '#abbreviate' do
    it "should return an abbreviated version of the given word" do
       sentence = "Institue of Engineering in Medicine Departments of Department of Institutes of Institute of"
       content = helper.abbreviate(sentence)

       content.should_not include("Institue of Engineering in Medicine")
       content.should_not include("Departments of")
       content.should_not include("Department of")
       content.should_not include("Institutes of")
       content.should_not include("Institute of")
       content.should include("IEM")
       content.should include("Depts.")
       content.should include("Dept.")
       content.should include("Insts.")
       content.should include("Inst.")
    end
  end
  
  context 'without events' do    
    describe '#build_table' do
      it "should raise an error" do
        lambda { raw helper.build_table(nil) }.should raise_error
      end
    end

    describe '#build_list' do
      it "should raise an error when no events are supplied" do
        lambda { raw helper.build_list(nil) }.should raise_error
      end
    end
  end
  
  context 'with events' do
    describe '#build_table' do
      it "should build an html table given an array of events" do
        events = []
        3.times { events << FactoryGirl.create(:event)}
        lambda { helper.build_table(events) }.should_not raise_error
      end
    end

    describe '#build_list' do
      it "should build an html table given an array of events" do
        events = []
        3.times { events << FactoryGirl.create(:event)}
        lambda { helper.build_list(events) }.should_not raise_error
      end
    end
  end

end




