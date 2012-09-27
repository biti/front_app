# encoding: utf-8
require 'ostruct'

class Order < ActiveRecord::Base

  STATUS = {
    :waiting_pay => {
      :value => 10,
      :text  => '等待付款',
    },
    :paid => {
      :value => 20,
      :text  => '已付款，等待发货',
    },
    :shipped => {
      :value => 30,
      :text  => '已发货，等待签收',
    },
    :received => {
      :value => 40,
      :text  => '已收到货物',
    },
    :completed => {
      :value => 50,
      :text  => '订单成功',
    },
  }
  
  attr_accessible :status, :subscriber_id, :partner_id, :num, :total_fee, :name,
    :state, :city, :district, :address, :email, :zip, :mobile, :tel, :ordered_at
  belongs_to :subscriber
  has_many :items, :class_name => 'OrderItem', :foreign_key => "order_id"
  
  has_many :pay_items, class_name: 'PayItem'
  has_many :pays, :through => :pay_items, :source => :pay

  def human_status
    STATUS.values.find{|item| item[:value] == status}[:text]
  end
  
  def waiting_pay?
    status == STATUS[:waiting_pay][:value]
  end
  
  def paid?
    status == STATUS[:paid][:value]
  end
  
  class << self
    
    # 生成订单，如果有多店订单拆分之
    def create_order(subscriber, address_id, cart_items)
      address = ShippingAddress.find_by_id(address_id)

      ids = cart_items.map{|item| item['sku_id']}
      items = []
      Sku.where(:id => ids).includes(:product).each do |sku|
        quantity = cart_items.find{|item| item['sku_id'].to_i == sku.id}.try(:[], 'quantity')
        if quantity
          items << {
            partner_id: sku.product.partner.id,
            product_id: sku.product.id,
            product_name: sku.product.name,
            image_url: sku.product.image1.url,
            product_custom_id: sku.product.custom_id,
            sku_id: sku.id,
            sku_custom_id: sku.custom_id,
            sku_specification: sku.specification,
            price: sku.price,
            quantity: quantity,
            total_fee: sku.price * quantity.to_i,
          }
        end
      end
      logger.debug items.inspect
      groups = items.group_by {|item| item[:partner_id]}

      logger.debug "[groups======%s]" % groups.inspect
      
      created_orders = []
      groups.each do |partner_id, items|
        
        transaction do
          order = Order.create(
            status: STATUS[:waiting_pay][:value],
            subscriber_id: subscriber.id,
            partner_id: partner_id,
            num: items.sum{|item| item[:quantity] },
            total_fee: items.sum{|item| item[:total_fee] },
            # Todo
            # ship_fee: 
          
            name: address.receiver,
            state: address.region.parent.parent.title,
            city: address.region.parent.title,
            district: address.region.title,
            address: address.address,
            email: address.email,
            zip: address.zip,
            mobile: address.mobile,
            tel: address.tel,
          
            ordered_at: Time.now
          )
        
          items.each { |item| order.items.create item }
          
          created_orders << order
        end
      end
      
      created_orders
    end

  end
  
end
