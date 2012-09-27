class CreateReports < ActiveRecord::Migration
  def change
    create_table :reports do |t|
      t.references :subscriber, :null => false
      t.references :product, :null => false
      t.decimal :price, :precision => 10, :scale => 2, :null => false
      t.string :retailer
      t.string :receipt_photo, :null => false
      t.decimal :receipt_price, :precision => 10, :scale => 2, :null => false
      t.date :receipt_date, :null => false
      t.timestamp :accepted_at
      t.timestamp :finished_at

      t.timestamps
    end
    add_index :reports, :subscriber_id
    add_index :reports, :product_id
  end
end
