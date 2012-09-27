class CreateBookmarks < ActiveRecord::Migration
  def change
    create_table :bookmarks do |t|
      t.references :subscriber, :null => false
      t.references :product, :null => false

      t.timestamps
    end
    add_index :bookmarks, :subscriber_id
    add_index :bookmarks, :product_id
    add_index :bookmarks, [ :subscriber_id, :product_id ], :unique => true
  end
end
