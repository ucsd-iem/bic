class Abstract < ActiveRecord::Base
  attr_accessible :affiliations, :attendee_attributes, :attendee_id, :authors, :biosketch, :body, :email, :event_attributes, :event_attributes, :event_id, :keyword_list, :order_id, :personal_statement, :position, :poster, :poster_number, :presentation, :presenter_affiliation, :presenter_first_name, :presenter_last_name, :presenter_middle_name, :session, :title, :video_url, :year
  
  acts_as_indexed :fields => [:title, :authors, :affiliations, :email, :keyword_list, :body ]
  
  belongs_to :attendee, :class_name => "Attendee", :foreign_key => "attendee_id"
#  belongs_to :event, :class_name => "Event", :foreign_key => "event_id"
  accepts_nested_attributes_for :attendee
#  belongs_to :event, :inverse_of => :abstracts
#  accepts_nested_attributes_for :event
  validates_presence_of :attendee
  
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