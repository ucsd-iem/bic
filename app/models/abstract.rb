class Abstract < ActiveRecord::Base
  attr_accessible :title, :authors, :affiliations, :email, :keyword_list, :body, :personal_statement, :year, :biosketch, :poster, :presentation, :position, :event_attributes, :event_id, :presenter_first_name, :presenter_middle_name, :presenter_last_name, :presenter_affiliation, :video_url, :attendee_id, :order_id

  belongs_to :attendee, :class_name => "Attendee", :foreign_key => "attendee_id"
  
  after_create :deliver_confirmation
#  after_save :deliver_update
  
  ActsAsTaggableOn.remove_unused_tags = true
  ActsAsTaggableOn.force_lowercase = true
  ActsAsTaggableOn.force_parameterize = true
  
  acts_as_taggable
  acts_as_taggable_on :keywords
  
  has_attached_file :biosketch
  has_attached_file :poster
  has_attached_file :presentation
  
  validates :title, :presence => true, :uniqueness => true
  validates :authors, :presence => true
  validates :affiliations, :presence => true
  validates :body, :presence => true
  validates :personal_statement, :presence => true

#  validates_attachment :poster, :presence => true
  validates_attachment_content_type :biosketch, :content_type => ['application/pdf', 'application/x-pdf'], :message => "must be pdf format (application/pdf or application/x-pdf)"
  validates_attachment_content_type :poster, :content_type => ['application/pdf', 'application/x-pdf'], :message => "must be pdf format (application/pdf or application/x-pdf)"
  
  rails_admin do
    edit do
      field :title
      field :authors
      field :affiliations
      field :keyword_list
      field :body
      field :year
      field :position
      field :email
      field :presenter_first_name
      field :presenter_middle_name
      field :presenter_last_name
      field :presenter_affiliation
      field :event
    end
    
    list do
      field :dynamic_title do
        label "Title"
      end
      
      sort_by :position
    end
    
    object_label_method do
      :dynamic_title
    end
    
  end

  # instance methods BEGIN

  def deliver_confirmation
    Notification.abstract_confirmation(self).deliver
  end

  def deliver_update
    Notification.abstract_update(self).deliver
  end

  def dynamic_title
    @title = "#{self.session_title} #{self.title}"
  end
  
  def session_title
    return unless self.position && self.position > 10
    
    session = Event::Romans[self.position.to_s[0].to_i]
    "#{session}-#{self.position.to_s[1]}"
  end

  def program_author
    if self.presenter_first_name && self.presenter_first_name.size > 2 && self.presenter_last_name
      self.presenter
    else
      self.authors
    end
  end
  
  def program_affiliation
    self.presenter_affiliation && self.presenter_affiliation.size > 2 ? self.presenter_affiliation : self.affiliations
  end
  
  def presenter
    "#{self.presenter_first_name} #{self.presenter_last_name}"
  end

end
