class Region < ActiveRecord::Base
  belongs_to :parent, :class_name => "Region"
  has_many :children, :class_name => "Region", :foreign_key => "parent_id"
  attr_accessible :level, :title
end
