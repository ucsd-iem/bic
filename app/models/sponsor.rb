class Sponsor < ActiveRecord::Base
  attr_accessible :contact_email, :contact_name, :contact_phone, :delete_logo, :email, :level, :logo, :mission_statement, :name, :phone, :position, :tagline, :url
  has_attached_file :logo
  attr_accessor :delete_logo
  
  validates_presence_of :name, :url, :level, :logo
  validates_inclusion_of :level, :in => %w( Dinner\ Sponsor Foundational Supporting ), :on => :create, :message => "'%s' is not a sponsor level, please use one from the list provided."
  
  scope :dinner, where(:level => 'Dinner Sponsor').order('name ASC')
  scope :foundational, where(:level => 'Foundational').order('name ASC')
  scope :supporting, where(:level => 'Supporting').order('name ASC')
  
end
