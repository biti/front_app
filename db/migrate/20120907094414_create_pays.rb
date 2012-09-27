class CreatePays < ActiveRecord::Migration
  def change
    create_table :pays do |t|
      t.integer :subscriber_id 
      
      t.decimal :need_pay,     :precision => 10, :scale => 0, :default => 0, :null => false
      t.decimal :paid,         :precision => 10, :scale => 0, :default => 0, :null => false
      t.decimal :pay_refunded, :precision => 10, :scale => 0, :default => 0, :null => false
      
      t.decimal :need_pay_cash,   :precision => 10, :scale => 0, :default => 0, :null => false
      t.decimal :paid_cash,       :precision => 10, :scale => 0, :default => 0, :null => false
      t.decimal :refunded_cash,   :precision => 10, :scale => 0, :default => 0, :null => false
      t.decimal :need_pay_credit, :precision => 10, :scale => 0, :default => 0, :null => false
      t.decimal :paid_credit,     :precision => 10, :scale => 0, :default => 0, :null => false
      t.decimal :refunded_credit, :precision => 10, :scale => 0, :default => 0, :null => false
      t.decimal :need_pay_online, :precision => 10, :scale => 0, :default => 0, :null => false
      t.decimal :paid_online,     :precision => 10, :scale => 0, :default => 0, :null => false
      t.decimal :refunded_online, :precision => 10, :scale => 0, :default => 0, :null => false
      
      t.datetime :started_at
      t.datetime :completed_at
      t.integer :status

      t.timestamps
    end
    
    add_index :pays, :subscriber_id
  end
end
