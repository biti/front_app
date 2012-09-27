class Authorization < ActiveRecord::Base
  belongs_to :subscriber
  attr_accessible :code, :email, :expired_at

  validates :subscriber, :presence => true
  validates :code, :presence => true
  validates :email, :presence => true
  validates :expired_at, :presence => true

  def expired?
    expired_at < Time.now
  end
end
