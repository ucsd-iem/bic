class Registrant < ActiveRecord::Base
  attr_accessible :affiliation, :email, :first_name, :last_name, :wednesday, :thursday, :friday, :phone, :special_needs, :food_preference
  
  validates :first_name, :presence => true
  validates :last_name, :presence => true
  validates :email, :presence => true
  validates_uniqueness_of :email
  validates :email, :email_format => true
  validates :affiliation, :presence => true
  validate :at_least_one_event
  
  before_save :make_token
  after_create :deliver_confirmation
  after_update :deliver_update_confirmation
    
  def deliver_confirmation
    Notification.confirmation(self).deliver
  end

  def deliver_update_confirmation
    Notification.update(self).deliver
  end
  
  def name
    @name = ""
    @name += "#{self.first_name} #{self.last_name}"
  end

  protected
  
  def at_least_one_event
    errors.add(:base, "You must attend at least one day to register.") unless wednesday || thursday || friday
  end
  
  def secure_digest(*args)
    Digest::SHA1.hexdigest(args.flatten.join('--'))
  end

  def make_token
    self.token = secure_digest(Time.now, (1..26).map{ rand.to_s })
  end

  
end
