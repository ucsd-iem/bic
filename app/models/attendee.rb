class Attendee < ActiveRecord::Base    
  attr_accessible :created, :email, :first_name, :last_name, :modified, :password, :password_confirmation, :remember_me
  devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable, :lockable, :token_authenticatable, :timeoutable
  before_save :ensure_authentication_token
  
  has_many :abstracts, :class_name => "Abstract"
  has_many :tickets, :class_name => "Ticket", :foreign_key => "attendee_id"

  validates_presence_of :email
  validates_presence_of :first_name
  validates_presence_of :last_name
  validates_uniqueness_of :email

  def name
    @name = ""
    @name += "#{self.first_name} #{self.last_name}"
  end
  
  def abstract
    self.abstracts.last
  end
end
