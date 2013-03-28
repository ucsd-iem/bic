class Moderator < ActiveRecord::Base
  attr_accessible :affiliaiton, :first_name, :last_name, :middle_name, :biosketch, :photo, :session_id, :event_attributes, :event_id
 # belongs_to :event, :inverse_of => :moderators
# accepts_nested_attributes_for :event

  has_attached_file :biosketch
  has_attached_file :photo
  
  def name
    "#{self.first_name} #{self.last_name}"
  end  
end