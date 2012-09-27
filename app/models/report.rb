class Report < ActiveRecord::Base

  belongs_to :subscriber
  belongs_to :product
  attr_accessible :receipt_date, :receipt_photo, :receipt_price, :retailer
  validates :subscriber, :presence => true
  validates :product, :presence => true
  validates :price, :presence => true
  validates :receipt_price, :presence => true
  validates :receipt_photo, :presence => true
  validate :receipt_price_should_be_less_than_price

  def accept
    self.accepted_at = Time.now if self.accepted_at.nil? && self.finished_at.nil?
  end

  def finish
    self.finished_at = Time.now if self.finished_at.nil?
  end

  # ------------------------------------------------------------
  private

  def receipt_price_should_be_less_than_price
    errors.add(:receipt_price, "should be less than price") if price && receipt_price && price <= receipt_price
  end

end
