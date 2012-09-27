class Returning < ActiveRecord::Base

  class InvalidStateException < Exception
  end

  SOLVED = 0
  CANCELLED = 1
  REJECTED = 2

  belongs_to :subscriber
  # belongs_to :order
  belongs_to :product

  validates :subscriber, :presence => true
  validates :product, :presence => true
  validates :quantity, :numericality => { :only_integer => true, :greater_than => 0 }
  validates :amount, :allow_nil => true, :numericality => { :greater_than => 0 }
  validates :settle, :allow_nil => true, :inclusion => { :in => [ SOLVED, CANCELLED, REJECTED ] }

  def accept(amount = nil)
    raise InvalidStateException if self[:settled_at] || self[:accepted_at]
    self[:accepted_at] = Time.now
    self[:amount] = amount
  end

  def deliver(deliverer, tracking_no)
    raise InvalidStateException if (self[:settled_at] ||
                                    self[:delivered_at] ||
                                    self[:accepted_at].nil?)
    self[:delivered_at] = Time.now
    self[:deliverer] = deliverer
    self[:tracking_no] = tracking_no
  end

  def solve(remark = nil)
    raise InvalidStateException if self[:settled_at] || self[:delivered_at].nil?
    self[:settled_at] = Time.now
    self[:settle] = SOLVED
    self[:remark] = remark
  end

  def cancel
    raise InvalidStateException if self[:settled_at] || self[:delivered_at]
    self[:settled_at] = Time.now
    self[:settle] = CANCELLED;
  end

  def reject(remark = nil)
    raise InvalidStateException if self[:settled_at] || self[:accepted_at]
    self[:settled_at] = Time.now
    self[:settle] = REJECTED
    self[:remark] = remark
  end

end
