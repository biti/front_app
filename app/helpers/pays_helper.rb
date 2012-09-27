# encoding: utf-8

module PaysHelper

  def alipay_filter_param(string)
    string.gsub(/[\r\n\s~@#\$%\^&\*\-+\|"]+/, '')
  end

  def tenpay_date
    Time.now.strftime("%Y%m%d")
  end

  def tenpay_transaction_id(pay_id)
    account = ActiveMerchant::Billing::Integrations::Tenpay::ACCOUNT
    "#{account}#{tenpay_date}#{"%.10i" % pay_id}".gsub(/\s/, '')
  end

  # 直连银行按钮
  #  form_selector: 生成的支付表单的jquery选择器
  #  bank_code_selector: 支付表单中银行代码一项的jquery选择器
  #  bank: 定义好的银行信息
  def bank_pay_button(form_selector, bank_code_input_selector, bank)
    
    link_to "#{pays_pay_url}?order_ids=#{params[:order_ids]}&pay_channel=bank&bank_type=#{bank[:code]}", 
        class: 'pay-channel', target: '_blank' do
      image_tag bank[:image_url], size: '120x36'
    end
  end
  
end