class ProductsController < ApplicationController
  layout 'products'

  def index
    @products = Product.order('id DESC').limit(20)
  end

  def show
    @product = Product.find params[:id]
    @related_products = Product.limit 5
    skus = @product.skus.map { |sku| sku.specification = JSON.parse(sku.specification); sku }
    @skus_json = skus.to_json

    arr  = skus.select{|s| s.num > 0 }.inject([]) {|arr, item| arr + item.specification}
    hash = arr.group_by {|item| item['property']}

    properties = []
    hash.each do |property, value|
      values = value.inject([]) { |arr, i| arr << i['value'] }
      properties << {label: property, choices: values.uniq}
    end
    @properties_json = properties.to_json
  end
end
