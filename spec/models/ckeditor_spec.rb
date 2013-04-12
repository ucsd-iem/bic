require 'spec_helper'

describe Ckeditor do
  
  describe Ckeditor::Picture do

    context "a new instance" do
      before(:each) { @pic = Ckeditor::Picture.new }
      
      it "should return the original image for a picture without a linked image" do
        @pic.url.should eq "/data/original/missing.png"
      end

      it "should return the url to the content sized image for a picture without a linked image" do
        @pic.url_content.should eq "/data/content/missing.png"
      end
    end
  end

  describe Ckeditor::AttachmentFile do

    context "a new instance" do
      before(:each) { @file = Ckeditor::AttachmentFile.new }
      
      it "should return the url to the original image for a new attachment without an image" do
        @file.url.should eq "/data/original/missing.png"
      end

      it "should return the url to the thumbnail for a new attachment without an image" do
        @file.url_thumb.should eq "/assets/ckeditor/filebrowser/images/thumbs/unknown.gif"
      end
    end
  end


end
