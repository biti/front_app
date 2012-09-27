class CreateInvitations < ActiveRecord::Migration
  def change
    create_table :invitations do |t|
      t.references :subscriber, :null => false
      t.string :code, :null => false

      t.timestamps
    end
    add_index :invitations, :subscriber_id
    add_index :invitations, :code, :unique => true
  end
end
