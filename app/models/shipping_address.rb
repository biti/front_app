class ShippingAddress < ActiveRecord::Base
  attr_accessible :receiver, :address, :mobile, :tel, :email, :zip
  belongs_to :subscriber
  belongs_to :region
  validates :receiver, :presence => true, :allow_blank => false
  validates :region, :presence => true
  validates :address, :presence => true, :allow_blank => false
  validates :email, :allow_nil => true, :format => {
    :with => /^[[:alnum:]._%-]+@[[:alnum:].-]+\.[[:alpha:]]{2,4}$/,
    :message => 'invalid'
  }
  validates :mobile, :allow_nil => true, :format => {
    :with => /^\d{11}$/,
    :message => 'invalid'
  }
  validates :tel, :allow_nil => true, :format => {
    :with => /^[\d-]+$/
  }
  validates :zip, :allow_nil => true, :format => {
    :with => /^\d{6}$/,
    :message => 'invalid'
  }

  def email= s
    super
    self[:email] = nil if self[:email] && self[:email].empty?
  end

  def mobile= s
    super
    self[:mobile] = nil if self[:mobile] && self[:mobile].empty?
  end

  def tel= s
    super
    self[:tel] = nil if self[:tel] && self[:tel].empty?
  end

  def zip= s
    super
    self[:zip] = nil if self[:zip] && self[:zip].empty?
  end
end
