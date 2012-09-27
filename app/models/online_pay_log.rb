class OnlinePayLog < ActiveRecord::Base
  attr_accessible :channel, :channel_no, :completed_at, :failure_reason, :paid,
    :out_pay_id, :pay_id, :started_at, :status, :notify_time, :raw_post, :notify_id, :params_string
    
  belongs_to :pay
  
  class << self
        
  end
end
