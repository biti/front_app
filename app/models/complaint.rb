class Complaint < ActiveRecord::Base
  belongs_to :subscriber
  # belongs_to :order
  belongs_to :product
  attr_accessible :content
  validates :subscriber, :presence => true
  validates :product, :presence => true
  validates :content, :presence => true, :allow_blank => false

  def accept
    self.accepted_at = Time.now if self.accepted_at.nil? && self.finished_at.nil?
  end

  def finish
    self.finished_at = Time.now if self.finished_at.nil?
  end
end
