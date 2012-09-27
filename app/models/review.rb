class Review < ActiveRecord::Base
  belongs_to :subscriber
  belongs_to :product
  attr_accessible :content, :rank, :title

  validates :subscriber, :presence => true
  validates :product, :presence => true
  validates :title, :presence => true, :allow_blank => false
  validates :content, :presence => true, :allow_blank => false
  validates :rank, :allow_nil => true, :inclusion => { :in => 1..5 }
end
