class CreateAuthorizations < ActiveRecord::Migration
  def change
    create_table :authorizations do |t|
      t.string :code, :null => false
      t.references :subscriber, :null => false
      t.string :email, :null => false
      t.datetime :expire_at, :null => false

      t.timestamps
    end
    add_index :authorizations, :subscriber_id
  end
end
