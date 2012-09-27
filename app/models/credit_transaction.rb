class CreditTransaction < ActiveRecord::Base
  ORDER = 0
  RETURN = 1

  belongs_to :credit
  # belongs_to :document
  attr_accessible :amount, :realm
  validates :credit, :presence => true
  validates :realm, :inclusion => { :in => [ ORDER, RETURN ] }
end
