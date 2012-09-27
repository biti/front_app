class CreateSubscriberDetails < ActiveRecord::Migration
  def change
    create_table :subscriber_details do |t|
      t.references :subscriber
      t.datetime :email_authorized_at
      t.datetime :mobile_authorized_at
      t.string :payment_password
      t.string :payment_salt
      t.references :rank
      t.date :rank_expire_at

      t.timestamps
    end
    add_index :subscriber_details, :subscriber_id
    add_index :subscriber_details, :rank_id
  end
end
