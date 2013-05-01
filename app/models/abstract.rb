class Abstract < ActiveRecord::Base
  attr_accessible :title, :authors, :affiliations, :email, :keyword_list, :body, :personal_statement, :year, :biosketch, :poster, :presentation, :position, :event_attributes, :event_id, :presenter_first_name, :presenter_middle_name, :presenter_last_name, :presenter_affiliation, :video_url, :attendee_id, :order_id, :event_attributes, :attendee_attributes
  
  acts_as_indexed :fields => [:title, :authors, :affiliations, :email, :keyword_list, :body ]
  
  belongs_to :attendee, :class_name => "Attendee", :foreign_key => "attendee_id"
#  belongs_to :event, :class_name => "Event", :foreign_key => "event_id"
  accepts_nested_attributes_for :attendee
#  belongs_to :event, :inverse_of => :abstracts
#  accepts_nested_attributes_for :event
  
  after_create :deliver_confirmation
  after_save :deliver_update
  
  ActsAsTaggableOn.remove_unused_tags = true
  ActsAsTaggableOn.force_lowercase = true
  ActsAsTaggableOn.force_parameterize = true
  
  acts_as_taggable
  acts_as_taggable_on :keywords
  
  has_attached_file :biosketch
  has_attached_file :poster
  has_attached_file :presentation
  
  paginates_per 10
  
  validates :title, :presence => true, :uniqueness => true
  validates :authors, :presence => true
  validates :affiliations, :presence => true
  validates :body, :presence => true

  def deliver_confirmation
    Notification.abstract_confirmation(self).deliver
  end

  def deliver_update
    Notification.abstract_update(self).deliver
  end
end