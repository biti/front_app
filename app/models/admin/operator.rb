require 'salt'

class Admin::Operator < ActiveRecord::Base
  attr_accessible :password, :salt, :username
  validates :username, :presence => true, :uniqueness => true
  validates :password, :presence => true
  validates :salt, :presence => true

  include Salt
end
