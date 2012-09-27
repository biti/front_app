class CreatePayItems < ActiveRecord::Migration
  def change
    create_table :pay_items do |t|
      t.integer :pay_id
      t.integer :order_id

      t.timestamps
    end
    
    add_index :pay_items, :pay_id
    add_index :pay_items, :order_id
  end
end
