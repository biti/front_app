class Invitation < ActiveRecord::Base
  belongs_to :subscriber
  attr_accessible :code
end
