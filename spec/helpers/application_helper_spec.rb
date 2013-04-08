require 'spec_helper'

describe 'ApplicationHelper' do
  describe '#right_content' do
    it "should return default content for the right side in an instance variable" do
      content = helper.right_content
      content.should eq '<h1>Sponsors</h1>'
    end
  end
end