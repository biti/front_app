# encoding: utf-8

class OrdersController < ApplicationController
  layout "subscribers"
  
  def index
    @orders = @subscriber.orders.page(params[:page]).per_page(10).order('id DESC')
  end

  def show
    @order = @subscriber.orders.find(params[:id])
  end
  
end
