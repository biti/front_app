# -*- encoding : utf-8 -*-

class Product < ActiveRecord::Base

  belongs_to :partner
  has_many :skus
  has_one :content, :class_name => 'ProductContent', :foreign_key => 'product_id'
  mount_uploader :image1, ProductImageUploader
  mount_uploader :image2, ProductImageUploader
  mount_uploader :image3, ProductImageUploader
  mount_uploader :image4, ProductImageUploader
  mount_uploader :image5, ProductImageUploader
  
end
