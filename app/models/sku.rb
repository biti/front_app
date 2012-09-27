# encoding: utf-8

class Sku < ActiveRecord::Base
  
  belongs_to :product, :class_name => 'Product', :foreign_key => 'product_id'

  def human_specification
    JSON.parse(specification).map { |item| "#{item['property']}:#{item['value']}" }.join(',')
  end
end
