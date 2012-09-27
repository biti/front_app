# encoding: utf-8

class PaysController < ApplicationController
  
  skip_before_filter :authorize, only: [:alipay_notify, :alipay_done, :tenpay_done]
  
  layout 'products'

  def new
    redirect_to root_path and return if params[:order_ids].blank?

    @subscriber = Subscriber.find(session[:subscriber_id])    
    @orders = @subscriber.orders.where(id: params[:order_ids].split(','))
    redirect_to root_path and return if @orders.blank?
    
    @total_fee  = @orders.sum(&:total_fee)
    @pay_cash   = [@total_fee, @subscriber.cash].min
    @pay_credit = [@total_fee - @pay_cash, @subscriber.credit].min
    @pay_online = @total_fee - @pay_cash - @pay_credit
  end

  def pay
    redirect_to root_path and return if params[:order_ids].blank?
    
    @orders = @subscriber.orders.where(id: params[:order_ids].split(','))
    redirect_to root_path and return if @orders.blank? or @orders.any?(&:paid?)

    @pay = Pay.create_pay(@subscriber, @orders)
    redirect_to pays_success_path and return if @pay.all_paid?
    
    case params[:pay_channel]
    when 'alipay'
      render template: 'pays/alipay', layout: false
    when 'tenpay'
      render template: 'pays/tenpay', layout: false
    when 'bank'
      render template: 'pays/tenpay', layout: false
    end
  end
  
  def alipay_notify
    notification = ActiveMerchant::Billing::Integrations::Alipay::Notification.new(request.raw_post)
    notification.acknowledge

    if notification.complete? or notification.trade_status == 'TRADE_SUCCESS'
      Pay.paid!(PAYMENT_CHANNEL[:tenpay][:ename], request.raw_post, notification)
      
      render :text => "success"
    else
      render :text => "failure"
    end
  end

  def alipay_done
    r = ActiveMerchant::Billing::Integrations::Alipay::Return.new(request.query_string)
    if r.success?
      flash[:notice] = '付款成功！'
    else
      flash[:error] = '付款失败！'
    end
  end
  
  def tenpay_done
    r = ActiveMerchant::Billing::Integrations::Tenpay::Return.new(request.query_string)
    logger.debug "[tenpay_done] return=======%s" % r.inspect
    
    if r.success?      
      Pay.paid!(PAYMENT_CHANNEL[:tenpay][:ename], request.query_string, r)
    end
  end

end