# encoding: utf-8
require 'ostruct'

class ShoppingController < ApplicationController
  
  layout 'products'
  def cart
    cart_items = JSON.parse(cookies[:cart] || '[]')
    generate_cart_datas cart_items  
  end
  
  def order
    cart_items = JSON.parse(cookies[:cart] || '[]')
    generate_cart_datas cart_items
    
    @subscriber = Subscriber.find(session[:subscriber_id])
    
    @shipping_address = @subscriber.shipping_addresses.new
  end
  
  def direct_order
    redirect_to root_path and return if params[:sku_id].blank? or params[:quantity].blank?
    
    cart_items = [ {'id' => params[:sku_id].to_i, 'quantity' => params[:quantity].to_i} ]
    generate_cart_datas cart_items
    
    render :template => 'shopping/order'
  end
  
  def save_order
    cookies.delete :cart
    
    @subscriber = Subscriber.find(session[:subscriber_id])
    
    orders = Order.create_order(@subscriber, params[:address_id], params[:items].values)
    
    redirect_to "#{pays_new_path}?order_ids=#{orders.map(&:id).join(',')}"
  end
  
  def edit_address
    @subscriber = Subscriber.find(session[:subscriber_id])
    @shipping_address = @subscriber.shipping_addresses.find_by_id(params[:id])
    
    render layout: false
  end
  
  def update_address
    @subscriber = Subscriber.find(session[:subscriber_id])
    @shipping_address = @subscriber.shipping_addresses.find_by_id(params[:id])
    @shipping_address.region = Region.find_by_id(params[:district])

    if @shipping_address.update_attributes(params[:shipping_address])
      render :template => 'shopping/address_item', :layout => false
    else
      render :json => {result: 'error', message: @shipping_address.errors.full_messages}
    end
  end
  
  def new_address
    @shipping_address = @subscriber.shipping_addresses.new
    render layout: false
  end
    
  def save_address
    @shipping_address = @subscriber.shipping_addresses.new(params[:shipping_address])
    @shipping_address.region = Region.find_by_id(params[:district])

    if @shipping_address.save
      render :template => 'shopping/new_address_item', :layout => false
    else
      render :json => {result: 'error', message: @shipping_address.errors.full_messages}
    end
  end

  private

  def generate_cart_datas(cart_items)
    ids = cart_items.map{|item| item['id']}

    items = []
    Sku.where(:id => ids).includes(:product).each do |sku|
      quantity = cart_items.find{|item| item['id'] == sku.id}.try(:[], 'quantity')
      if quantity
        items << OpenStruct.new(
          product_name: sku.product.name,
          sku_specification: sku.human_specification,
          sku_id: sku.id,
          product_id: sku.product_id, 
          quantity: quantity,
          price: sku.price,
          image_url: sku.product.image1.url,
          partner_name: sku.product.partner.name
        )
      end
    end
    
    @cart_datas = items.group_by(&:partner_name)
    @total_fee  = items.sum {|item| item.price * item.quantity}
  end
end