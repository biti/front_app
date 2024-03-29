class Category < ActiveRecord::Base
  
  attr_accessible :name
  
  validates_presence_of :name
  
  belongs_to :parent, :class_name => 'Category', :foreign_key => 'parent_id'
  has_many :children, :class_name => 'Category', :foreign_key => 'parent_id'
end