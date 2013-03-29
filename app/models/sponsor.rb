class Sponsor < ActiveRecord::Base
  attr_accessible :contact_email, :contact_name, :contact_phone, :delete_logo, :email, :level, :logo, :mission_statement, :name, :phone, :position, :tagline, :url
  has_attached_file :logo
  attr_accessor :delete_logo
  
  validates_presence_of :name, :url, :level, :logo
  validates_inclusion_of :level, :in => %w( Dinner\ Sponsor Foundational Supporting ), :on => :create, :message => "'%s' is not a sponsor level, please use one from the list provided."
  
  rails_admin do
    edit do
      field :name
      field :url
      field :level, :enum do
        enum do
          %w{ Dinner\ Sponsor Foundational Supporting }
        end
      end
      field :logo
      field :tagline do
        html_attributes rows: 2
      end
      field :mission_statement do
        html_attributes rows: 6
#        ckeditor true
      end
      include_all_fields
    end
  end
end
