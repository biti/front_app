class CreateShippingAddresses < ActiveRecord::Migration
  def change
    create_table :shipping_addresses do |t|
      t.references :subscriber, :null => false
      t.string :receiver, :null => false
      t.references :region      # , :null => false
      t.string :address, :null => false
      t.string :mobile
      t.string :tel
      t.string :email
      t.string :zip

      t.timestamps
    end

    add_index :shipping_addresses, :subscriber_id
  end
end
