class CreateAdminOperators < ActiveRecord::Migration
  def change
    create_table :admin_operators do |t|
      t.string :username, :null => false
      t.string :password, :null => false
      t.string :salt, :null => false

      t.timestamps
    end

    add_index :admin_operators, :username, :unique => true
  end
end
