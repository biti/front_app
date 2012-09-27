class Partner < ActiveRecord::Base
  has_many :products
  
  def home_product
    #每个商家都在首页会有一款要展示的产品
    self.products.first
  end
end
