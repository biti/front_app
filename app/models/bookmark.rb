class Bookmark < ActiveRecord::Base
  belongs_to :subscriber
  belongs_to :product
  # attr_accessible :title, :body
  validates :subscriber, :presence => true
  validates :product, :presence => true
end
