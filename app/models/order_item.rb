class OrderItem < ActiveRecord::Base
  attr_accessible :partner_id, :product_name, :sku_specification, :price, :image_url, 
    :sku_id, :product_id, :quantity,  :product_custom_id, :sku_custom_id, :total_fee
    
  belongs_to :order, :class_name => 'Order', :foreign_key => "order_id"
  belongs_to :product
  belongs_to :sku
  
end