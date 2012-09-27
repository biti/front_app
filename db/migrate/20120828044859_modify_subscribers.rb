class ModifySubscribers < ActiveRecord::Migration
  def up
    remove_index :subscribers, :mail
    remove_index :subscribers, :phone

    change_table :subscribers do |t|
      t.rename :mail, :email
      t.rename :passphrase, :password
      t.remove :realname
      t.remove :birth
      t.remove :gender
      t.remove :married
      t.rename :phone, :mobile
      t.remove :rank_id
      t.remove :expired_at
      t.rename :balance, :cash
      t.rename :blocked, :credit
      t.remove :credits
    end

    add_index :subscribers, :email, :unique => true
    add_index :subscribers, :mobile, :unique => true
  end

  def down
    remove_index :subscribers, :email
    remove_index :subscribers, :mobile

    change_table :subscribers do |t|
      t.rename :email, :mail
      t.rename :password, :passphrase
      t.string :realname
      t.date :birth
      t.boolean :gender
      t.boolean :married
      t.rename :mobile, :phone
      t.references :rank
      t.date :expired_at
      t.rename :cash, :balance
      t.rename :credit, :blocked
      t.integer :credits, :null => false, :default => 0
    end

    add_index :subscribers, :mail, :unique => true
    add_index :subscribers, :phone, :unique => true
  end
end
