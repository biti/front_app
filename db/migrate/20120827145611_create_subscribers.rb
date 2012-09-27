class CreateSubscribers < ActiveRecord::Migration
  def change
    create_table :subscribers do |t|
      t.string :mail, :null => false
      t.string :passphrase, :null => false
      t.string :sigil, :null => false
      t.references :initiator
      t.string :nickname
      t.string :realname
      t.date :birth
      t.boolean :gender
      t.boolean :married
      t.string :phone
      t.references :region
      t.references :rank
      t.date :expired_at
      t.decimal :balance, :scale => 2, :null => false, :default => 0
      t.decimal :blocked, :scale => 2, :null => false, :default => 0
      t.integer :credits, :null => false, :default => 0

      t.timestamps
    end
    add_index :subscribers, :mail, :unique => true
    add_index :subscribers, :phone, :unique => true
    add_index :subscribers, :initiator_id
  end
end
