class CreateReturnings < ActiveRecord::Migration
  def change
    create_table :returnings do |t|
      t.references :subscriber, :null => false
      t.references :order
      t.references :product, :null => false
      t.integer :quantity, :null => false
      t.string :cause
      t.timestamp :settled_at
      t.integer :settle
      t.string :remark
      t.timestamp :accepted_at
      t.decimal :amount, :precision => 10, :scale => 2
      t.timestamp :delivered_at
      t.string :deliverer
      t.string :tracking_no

      t.timestamps
    end
    add_index :returnings, :subscriber_id
    add_index :returnings, :order_id
    add_index :returnings, :product_id
  end
end
