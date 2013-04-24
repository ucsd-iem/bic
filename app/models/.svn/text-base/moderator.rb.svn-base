class Moderator < ActiveRecord::Base
  attr_accessible :affiliaiton, :first_name, :last_name, :middle_name, :biosketch, :photo, :session_id, :event_attributes, :event_id
    
  belongs_to :event, :inverse_of => :moderators
  accepts_nested_attributes_for :event


  has_attached_file :biosketch
  has_attached_file :photo
  
  rails_admin do
    object_label_method do
      :name
    end
    field :first_name
    field :middle_name
    field :last_name
    field :affiliaiton
    field :biosketch
    field :photo
    
    field :event do
      nested_form false
    end
  end
  
  def name
    "#{self.first_name} #{self.last_name}"
  end
  

end
