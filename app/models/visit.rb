class Visit < ActiveRecord::Base
  belongs_to :region
  belongs_to :subscriber
  attr_accessible :cdn, :client_key, :content, :ip, :ref, :session_id, :source, :type, :url
end
