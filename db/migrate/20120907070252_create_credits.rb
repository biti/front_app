class CreateCredits < ActiveRecord::Migration
  def change
    create_table :credits do |t|
      t.references :subscriber, :null => false
      t.references :order
      t.decimal :amount, :precision => 10, :scale => 2, :null => false
      t.date :expired_at, :null => false

      t.timestamps
    end
    add_index :credits, :subscriber_id
    add_index :credits, :order_id
  end
end
