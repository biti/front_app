class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.references :subscriber, :null => false
      t.references :product, :null => false
      t.integer :rank
      t.string :title, :null => false
      t.string :content, :null => false

      t.timestamps
    end
    add_index :reviews, :subscriber_id
    add_index :reviews, :product_id
    add_index :reviews, [ :subscriber_id, :product_id ], :unique => true
  end
end
