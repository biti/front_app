# encoding: utf-8

class Pay < ActiveRecord::Base
  attr_accessible :completed_at, :need_pay, :paid, :pay_refunded, :started_at, :status, :subscriber_id, 
    :need_pay_cash, :paid_cash, :need_pay_credit, :paid_credit, :need_pay_online
    
  has_many :items, class_name: 'PayItem'
  has_many :orders, :through => :items, :source => :order

  STATUS = {
    no_pay: {
      value: 10,
      text: '没有支付',
    },
    part_paid: {
      value: 20,
      text: '部分支付',
    },
    all_paid: {
      value: 30,
      text: '已付全款',
    },
  }

  def all_paid?
    status == STATUS[:all_paid][:value]
  end
  
  class << self
    
    # 创建支付计划并暂扣账户余额
    def create_pay(subscriber, orders)
      
      # 计算各个支付金额
      need_pay    = orders.sum(&:total_fee)
      need_pay_cash   = [need_pay, subscriber.cash].min
      need_pay_credit = [need_pay - need_pay_cash, subscriber.credit].min
      need_pay_online = need_pay - need_pay_cash - need_pay_credit
      
      subscriber.cash   -= need_pay_cash
      subscriber.credit -= need_pay_credit
      
      status = STATUS[:no_pay][:value]
      status = STATUS[:part_paid][:value] if (need_pay_cash + need_pay_credit) > 0
      status = STATUS[:all_paid][:value] if (need_pay_cash + need_pay_credit) >= need_pay
      
      transaction do
        subscriber.save
        
        pay = Pay.create!(
          subscriber_id: subscriber.id,
          need_pay: need_pay,

          paid: need_pay_cash + need_pay_credit,
          
          need_pay_cash: need_pay_cash,
          paid_cash: need_pay_cash,
          need_pay_credit: need_pay_credit,
          paid_credit: need_pay_credit,
          
          need_pay_online: need_pay_online,

          started_at: Time.now,
          status: status
        )
        
        orders.each { |order| pay.items.create(pay_id: pay.id, order_id: order.id) }
        
        orders.each { |order| order.increment!(:payment, pay.paid) }
        
        if pay.all_paid?
          orders.each { |order| order.update_attribute(:status, Order::STATUS[:paid][:value]) }
          
          # 同步库存和销量
          orders.each do |order|
            order.items.each { |item| raise '库存不足！' if item.sku.num < item.quantity }
            order.items.each { |item| item.sku.increment!(:num, -item.quantity)}
            order.items.each { |item| item.product.increment!(:sell_num, item.quantity) }
          end
        end
        
        pay
      end
    end
    
    # 处理支付
    def paid!(channel, params_string, notification)
      params = {
        :paid         => BigDecimal(notification.total_fee),
        :status       => notification.trade_status,
        :pay_id       => notification.out_trade_no,
        :out_pay_id   => notification.trade_no,
        :notify_time  => Time.now,
        :params_string => params_string,
        :channel      => channel,
      }
      return if OnlinePayLog.find_by_pay_id(params[:pay_id])
      
      pay = Pay.find_by_id(params[:pay_id])
      return if pay.blank? or pay.all_paid?
      
      pay.paid_online = params[:paid]
      pay.paid += params[:paid]
      pay.status = STATUS[:part_paid][:value] if pay.paid > 0
      pay.status = STATUS[:all_paid][:value] if pay.paid >= pay.need_pay
      
      transaction do
        OnlinePayLog.create!(params)
        
        pay.save!
        
        pay.orders.each do |order| 
          order.items.each { |item| raise '库存不足！' if item.sku.num < item.quantity }
          order.increment!(:payment, pay.paid) 
        end
        
        if pay.all_paid?
          pay.orders.each { |order| order.update_attribute(:status, Order::STATUS[:paid][:value]) }
          
          # 同步库存和销量
          pay.orders.each do |order|
            
            order.items.each { |item| item.sku.increment!(:num, -item.quantity)}
            order.items.each { |item| item.product.increment!(:sell_num, item.quantity)}
          end
        end
      end
    end
    
  end
end


