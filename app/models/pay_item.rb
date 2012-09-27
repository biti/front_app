class PayItem < ActiveRecord::Base
  attr_accessible :order_id, :pay_id
  
  belongs_to :pay
  belongs_to :order
  
end
