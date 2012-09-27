# -*- coding: utf-8 -*-

require 'net/http'
require 'uri'

url = URI.parse('http://localhost:3000/pays/alipay_notify')
params =  {"body"=>"body", "buyer_email"=>"liuzihua8@gmail.com", "buyer_id"=>"2088102094662455", 
  "exterface"=>"create_direct_pay_by_user", "is_success"=>"T", 
  "notify_id"=>"RqPnCoPT3K9%2Fvwbh3I71lFvmrJzaTlX4k3eWktH5pMGc3IlGImlrt8bK0oNR55SzR8iI", 
  "notify_time"=>"2012-09-08 20:37:32", "notify_type"=>"trade_status_sync", "out_trade_no"=>"148", 
  "payment_type"=>"8", "seller_email"=>"fantongwangcaiwu@fantong.com", 
  "seller_id"=>"2088301386242425", 
  "subject"=>"kuaipinhui.com", 
  "total_fee"=>"0.03", 
  "trade_no"=>"2012090818630445", 
  "trade_status"=>"TRADE_SUCCESS", 
  "sign"=>"a99396bccbbbec85064c40f2f10701b3", 
  "sign_type"=>"MD5"}

res = Net::HTTP.post_form url, params

puts "alipay notify..."
puts res.body

# get_data = {"price"=>"1.00", "discount"=>"0.00", "quantity"=>"1", "out_trade_no"=>"fanpiao-20100825-2088301386242425-6", "body"=>"11<br />", "trade_status"=>"TRADE_SUCCESS", "is_total_fee_adjust"=>"N", "total_fee"=>"1.00", "subject"=>"测试商品", "buyer_id"=>"2088002176508070", "gmt_create"=>"2010-08-25 11:35:31", "notify_time"=>"2010-08-25 15:01:01", "seller_id"=>"2088301386242425", "sign"=>"3e17dd580fc4ca2a524bda31ae9ce986", "trade_no"=>"2010082534793807", "use_coupon"=>"N", "buyer_email"=>"5i5i7@163.com", "notify_type"=>"trade_status_sync", "payment_type"=>"1", "gmt_payment"=>"2010-08-25 11:37:09", "seller_email"=>"fantongwangcaiwu@fantong.com", "notify_id"=>"18258521142d41ad226493705a88648600", "sign_type"=>"MD5"}.map{ |k, v| "#{k}=#{v}"}.join("&")
# 
# url = URI.parse(URI.encode "http://local.fantong.com:3000/alipay/feedback?#{get_data}")
# res = Net::HTTP.start(url.host, url.port) {|http|
#   http.get("#{url.path}?#{url.query}")
# }
# puts res.body

=begin
url = URI.parse('http://ticket.fantong.com:3000/chinabank/notify')
form_data = {"remark2"=>"[url:=http://piao.fantong.com/chinabank/feedback]", "v_md5money"=>"71cb47b8c8a06826c0b9a55feeab6b9a", "v_pmode"=>"ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½", "v_idx"=>"5455986512", "v_pstring"=>"Ö§\270\266\263É¹\246", "v_md5all"=>"D854B9C668D116D8F39A3D6B071BD6DB", "v_md5info"=>"b452b57288e501c0554c45938fa25bfb", "v_md5"=>"9BA5941345E790D28BC79FDBC2886CE7", "v_pstatus"=>"20", "v_amount"=>"1.00", "v_oid"=>"fanpiao-20100825-21706189-14", "v_md5str"=>"9BA5941345E790D28BC79FDBC2886CE7", "remark1"=>"\261\261\276\251\262ï¿½ï¿½ï¿½ï¿½ï¿½Æ·", "v_moneytype"=>"CNY"}

res = Net::HTTP.post_form url, form_data

puts "chinabank notify..."
puts res.body

url = URI.parse('http://ticket.fantong.com:3000/chinabank/feedback')
form_data = {"remark2"=>"[url:=http://piao.fantong.com/chinabank/feedback]", "TranSerialNum"=>"5455986512", "v_pmode"=>"ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½", "v_pstring"=>"Ö§\270\266\263É¹\246", "v_pstatus"=>"20", "v_amount"=>"1.00", "v_md5info"=>"b452b57288e501c0554c45938fa25bfb", "v_oid"=>"fanpiao-20100825-21706189-14", "v_md5str"=>"9BA5941345E790D28BC79FDBC2886CE7", "v_moneytype"=>"CNY", "remark1"=>"\261\261\276\251\262ï¿½ï¿½ï¿½ï¿½ï¿½Æ·"}
res = Net::HTTP.post_form url, form_data
puts "chinabank feedback..."
puts res.body
=end
