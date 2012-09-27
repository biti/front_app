require 'salt'

class Subscriber < ActiveRecord::Base
  attr_accessible :email, :nickname, :mobile
  belongs_to :initiator, :class_name => "Subscriber"
  belongs_to :region
  has_many :invitees, :class_name => "Subscriber", :foreign_key => "initiator_id"
  has_one :detail, :class_name => "SubscriberDetail"
  has_one :authorization
  has_many :invitations
  has_many :shipping_addresses
  has_many :orders
  has_many :credit_components, :class_name => "Credit"
  has_many :returnings
  has_many :bookmarks
  has_many :reviews
  has_many :complaints
  has_many :reports
  has_many :notifications, :foreign_key => "to_id"

  validates :email, :uniqueness => true, :presence => true, :format => {
    :with => /^[[:alnum:]._%-]+@[[:alnum:].-]+\.[[:alpha:]]{2,4}$/,
    :message => "invalid"
  }
  validates :mobile, :allow_nil => true, :uniqueness => true

  include Salt

  def consume_credit(amount)
    self.credit_components.where("expired_at >= ?", Date.today).order("expired_at").each do
      | c |

      c.subscriber = self       # no IdentityMap
      amount = c.consume(amount)
      break if amount < 0.01
    end
    amount
  end

  def payback_credit(amount)
    # TODO: payback MUST consult corresponding consume,
    # via order or so.
  end

end
