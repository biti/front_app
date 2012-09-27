# encoding: utf-8

###### 修改财付通接口的链接 ######
module ActiveMerchant #:nodoc:
  module Billing #:nodoc:
    module Integrations #:nodoc:
      module Tenpay

        mattr_accessor :service_url
        self.service_url = 'http://service.tenpay.com/cgi-bin/v3.0/payservice.cgi'

      end
    end
  end
end

module ActiveMerchant #:nodoc:
  module Billing #:nodoc:
    module Integrations #:nodoc:
      module Tenpay
        class Return < ActiveMerchant::Billing::Integrations::Return

          def out_trade_no
            @params["sp_billno"]
          end
          
          def trade_no
            @params['transaction_id']
          end
          
          def trade_status
            @params['pay_info']           
          end

          def total_fee
            ( BigDecimal(@params["total_fee"])/100 ).round(2)
          end
        end
      end
    end
  end
end
###### 修改财付通接口的链接结束 ######


###### 修改财付通参数和sign算法 ######
module ActiveMerchant #:nodoc:
  module Billing #:nodoc:
    module Integrations #:nodoc:
      module Tenpay
        class Helper < ActiveMerchant::Billing::Integrations::Helper
          mapping :key, 'key'
          mapping :bargainor_id, 'bargainor_id'
          mapping :total_fee, 'total_fee'

          mapping :sp_billno, 'sp_billno'

          mapping :cmdno, 'cmdno'
          mapping :return_url, 'return_url'
          mapping :desc, 'desc'
          mapping :attach, 'attach'
          mapping :date, 'date'
          mapping :fee_type, 'fee_type'
          mapping :transaction_id, 'transaction_id'

          mapping :spbill_create_ip, 'spbill_create_ip'
          mapping :bank_type, 'bank_type' 
          mapping :cs, 'cs' 

          def initialize(order, account, options = {})
            super
          end

          def sign
            add_field('sign',
              Digest::MD5.hexdigest("cmdno=#{cmdno}&date=#{date}&bargainor_id=#{bargainor_id}" +
              "&transaction_id=#{transaction_id}&sp_billno=#{sp_billno}&total_fee=#{total_fee}" +
              "&fee_type=#{fee_type}&return_url=#{return_url}&attach=#{attach}" + 
              "&spbill_create_ip=#{spbill_create_ip}&key=#{KEY}"))
          end

        end
      end
    end
  end
end
###### 修改财付通参数和sign算法结束 ######

# ActiveMerchant::Billing::Integrations::Alipay::KEY     = '9mh38761s99r2uf2g6ry6eqgyhqd9c4b'
# ActiveMerchant::Billing::Integrations::Alipay::ACCOUNT = '2088702943129201'
# ActiveMerchant::Billing::Integrations::Alipay::EMAIL   = '2468402414@qq.com'

ActiveMerchant::Billing::Integrations::Alipay::KEY = '82n30fe27pmibpy39a93m8mgc52euyxj'
ActiveMerchant::Billing::Integrations::Alipay::ACCOUNT = '2088301386242425'
ActiveMerchant::Billing::Integrations::Alipay::EMAIL = 'fantongwangcaiwu@fantong.com'

ActiveMerchant::Billing::Integrations::Tenpay::ACCOUNT = '1209352701'
ActiveMerchant::Billing::Integrations::Tenpay::KEY = '924648c696b83e6f138a62cbd7f3de50'

PAYMENT_CHANNEL = {
  tenpay: {
    ename: 'tenpay',
    image_url: 'pay/tenpay.jpg',
    banks: [
      {code: '1001', name: '招商银行', image_url: 'pay/zsyh.jpg'},
      {code: '1002', name: '中国工商银行', image_url: 'pay/gsyh.jpg'},
      {code: '1003', name: '中国建设银行', image_url: 'pay/jsyh.jpg'},
      {code: '1004', name: '上海浦东发展银行', image_url: 'pay/shpfyh.jpg'},
      {code: '1005', name: '中国农业银行', image_url: 'pay/nyyh.jpg'},
      {code: '1006', name: '中国民生银行', image_url: 'pay/msyh.jpg'},
    ],
  },
  
  alipay: {
    ename: 'alipay',
    image_url: 'pay/tenpay.jpg',
    bank_types: [],
  },
  
}



