class Admin::LandingPage < ActiveRecord::Base
  belongs_to :region
  attr_accessible :background_image, :domain
  validates :domain, :allow_nil => true, :format => {
    :with => /^(\*|([\w-]+\.){1,}[[:alpha:]]+)$/,
    :message => 'invalid'
  }
  validates :background_image, :presence => true

  def domain= s
    super
    self[:domain] = nil if self[:domain] && self[:domain].empty?
  end
end
