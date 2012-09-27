class Credit < ActiveRecord::Base
  belongs_to :subscriber
  # belongs_to :order
  has_many :transactions, :class_name => "CreditTransaction"
  attr_accessible :amount, :expired_at
  validates :subscriber, :presence => true
  validates :amount, :numericality => { :greater_than => 0 }

  def expired?
    self.expired_at < Date.today
  end

  def balance
    s = self.transactions.sum(:amount)
    # assert s <= 0
    self.amount + s
  end

  # amount > 0
  def consume(amount)
    a = self.balance
    return amount if self.expired? || a < 0.01
    a = amount if amount < a
    tr = self.transactions.new
    tr.amount = -a
    tr.realm = CreditTransaction::ORDER
    tr.save
    self.subscriber.credit -= a
    amount - a
  end

  # amount > 0
  def payback(amount)
    a = self.amount - self.balance
    return amount if a < 0.01
    a = amount if amount < a
    tr = self.transactions.new
    tr.amount = a
    tr.realm = CreditTransaction::RETURN
    tr.save
    self.subscriber.credit += a unless self.expired?
    amount - a
  end

end
