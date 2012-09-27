# encoding: utf-8

class MoveOaSchemaInFrontApp < ActiveRecord::Migration
  def up
    
    # 产品表
    create_table "products", :force => true do |t|
      t.string   "custom_id", :comment => '商家自定义字段'
      t.string   "name", :comment => '名称'
      t.string   "title", :comment => '标题'
      t.integer  "num", :comment => '总库存'
      t.integer  "sell_num", :comment => '已经卖出数量'
      t.decimal  "price", :comment => '售卖价'
      t.decimal  'market_price', :comment => '市场价'
      t.integer  "status", :comment => '状态'
      t.string   "header_image_url", :comment => '头图链接'
      t.integer  "user_id", :comment => '商家id'
      t.boolean  "has_invoice", :comment => '是否有发票'
      t.boolean  "can_maintain", :comment => '是否能保修'
      
      t.datetime "created_at"
      t.datetime "updated_at"
    end
    add_index "products", ["user_id"], :name => "index_products_on_user_id"
    
    # 产品表的大字段内容放这里
    create_table "product_contents", :force => true do |t|
      t.integer 'product_id', :comment => '产品id'
      t.text 'description', :comment => '详情'
    end
    
    # sku　最小库存单位表
    create_table "skus", :force => true do |t|
      t.string  "custom_id", :comment => '商家自定义编码'
      t.integer  "product_id", :comment => '关联产品id'
      t.decimal  "price", :comment => '售卖价格'
      t.string   "specification", :comment => '规格'
      t.integer  "num", :comment => '库存'
      t.integer  "user_id", :comment => '商家id'

      t.datetime "created_at"
      t.datetime "updated_at"
    end
    add_index "skus", ["product_id"], :name => "index_skus_on_product_id"
    add_index "skus", ["user_id"], :name => "index_skus_on_user_id"
    
    #　商家表
    create_table "partners", :force => true do |t|
      t.string   "name", :comment => '商家名称'
      t.string   "login", :comment => '登录用户名'
      t.string   "password", :comment => '密码'
      t.string   "salt", :comment => 'salt'
      t.string   "mobile", :comment => '手机'
      t.string   'tel', :comment => '座机'
      
      t.datetime "created_at"
      t.datetime "updated_at"
    end
    
    create_table :admins do |t|
      t.string   "username"
      t.string   "password"
      t.string   "realname"
      t.string   "permissions"
      t.string   "salt"
      t.string   "phone"
      #t.string   "register_code"
      t.timestamps
    end
    
    add_column :products, :is_delete, :boolean, :comment => '是否删除'
    add_column :products, :audit_status, :integer, :comment => '审核状态'
    
    rename_column :products, :user_id, :partner_id

    # 产品属性
    create_table "properties", :force => true do |t|
      t.integer 'product_id', :comment => '产品id'
      t.string 'name', :comment => '属性名'
    end
    add_index :properties, :product_id
    
    # 产品属性值
    create_table "property_values", :force => true do |t|
      t.integer 'property_id', :comment => '属性id'
      t.string 'name', :comment => '属性值'
    end
    add_index :property_values, :property_id

    create_table :categories do |t|
      t.string  :name
      t.integer :parent_id
    end
    
    add_column :products, :category_id, :integer
    
    add_column :partners, :brand, :string, :comment => '品牌'
    add_column :partners, :company, :string, :comment => '公司名称'
    add_column :partners, :intro, :string, :comment => '公司简介'
    add_column :partners, :designer_img, :string, :comment => '设计师图片'
    
    add_column :products, :image1, :string
    add_column :products, :image2, :string
    add_column :products, :image3, :string
    add_column :products, :image4, :string
    add_column :products, :image5, :string
    
    add_column :products, :audit_note, :string
    
    create_table :orders do |t|
      t.string :delivery_no
      t.string :address 
      t.integer :num
      t.string :delivery_company 
      t.datetime :ordered_at 
      t.string :name 
      t.string :mobile 
      t.string :tel 
      t.string :email 
      t.string :remark 
      t.string :state 
      t.string :city  
      t.string :district
      t.string :zip 
      t.string :consign_time 
      t.integer :status
      t.string :buyer_nick
      
      t.decimal :total_fee, :scale => 2, :null => false, :default => 0
      t.decimal :payment,   :scale => 2, :null => false, :default => 0
      t.decimal :ship_fee, :scale => 2, :null => false, :default => 0
      
      t.integer :subscriber_id
      
    end
    add_index :orders, :subscriber_id
    
    create_table :order_items do |t|
      t.integer :order_id
      t.integer :product_id
      t.string :product_name
      t.integer :product_custom_id
      t.integer :sku_id
      t.string :sku_custom_id
      t.string :sku_specification
      t.integer :quantity
      t.decimal :price, :scale => 2, :null => false, :default => 0
      t.decimal :total_fee, :scale => 2, :null => false, :default => 0
      t.decimal :payment, :scale => 2, :null => false, :default => 0
      t.string :image_url
    end
    add_index :order_items, :order_id
    
    add_column :orders, :partner_id, :integer
    add_index :orders, :partner_id
    add_column :order_items, :partner_id, :integer
    
    change_column :products, :market_price, :decimal, :precision => 10, :scale => 2, :default => 0, :null => false
    change_column :products, :price, :decimal, :precision => 10, :scale => 2, :default => 0, :null => false

    change_column :skus, :price,           :decimal, :precision => 10, :scale => 2, :default => 0, :null => false

    change_column :pays, :need_pay,        :decimal, :precision => 10, :scale => 2, :default => 0, :null => false
    change_column :pays, :paid,            :decimal, :precision => 10, :scale => 2, :default => 0, :null => false
    change_column :pays, :pay_refunded,    :decimal, :precision => 10, :scale => 2, :default => 0, :null => false
    change_column :pays, :need_pay_cash,   :decimal, :precision => 10, :scale => 2, :default => 0, :null => false
    change_column :pays, :paid_cash,       :decimal, :precision => 10, :scale => 2, :default => 0, :null => false
    change_column :pays, :refunded_cash,   :decimal, :precision => 10, :scale => 2, :default => 0, :null => false
    change_column :pays, :need_pay_credit, :decimal, :precision => 10, :scale => 2, :default => 0, :null => false
    change_column :pays, :paid_credit,     :decimal, :precision => 10, :scale => 2, :default => 0, :null => false
    change_column :pays, :refunded_credit, :decimal, :precision => 10, :scale => 2, :default => 0, :null => false
    change_column :pays, :need_pay_online, :decimal, :precision => 10, :scale => 2, :default => 0, :null => false
    change_column :pays, :paid_online,     :decimal, :precision => 10, :scale => 2, :default => 0, :null => false
    change_column :pays, :refunded_online, :decimal, :precision => 10, :scale => 2, :default => 0, :null => false

    change_column :online_pay_logs,  :paid,     :decimal, :precision => 10, :scale => 2, :default => 0, :null => false

    change_column :orders, :total_fee, :decimal, :precision => 10, :scale => 2, :default => 0, :null => false
    change_column :orders, :payment,   :decimal, :precision => 10, :scale => 2, :default => 0, :null => false
    change_column :orders, :ship_fee,  :decimal, :precision => 10, :scale => 2, :default => 0, :null => false

    change_column :order_items, :price,     :decimal, :precision => 10, :scale => 2, :default => 0, :null => false
    change_column :order_items, :total_fee, :decimal, :precision => 10, :scale => 2, :default => 0, :null => false
    change_column :order_items, :payment,   :decimal, :precision => 10, :scale => 2, :default => 0, :null => false
    
    add_column :online_pay_logs, :params_string, :string
    add_column :online_pay_logs, :out_pay_id, :string

    add_index :online_pay_logs, :notify_id
    
    add_column :products, :is_group_promotion, :boolean
    add_column :products, :group_promotion, :decimal, :precision => 10, :scale => 2
  end

  def down
  end
end
