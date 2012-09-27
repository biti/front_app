class CreateComplaints < ActiveRecord::Migration
  def change
    create_table :complaints do |t|
      t.references :subscriber
      t.references :order
      t.references :product
      t.string :content
      t.timestamp :accepted_at
      t.timestamp :finished_at
      t.string :remark

      t.timestamps
    end
    add_index :complaints, :subscriber_id
    add_index :complaints, :order_id
    add_index :complaints, :product_id
  end
end
