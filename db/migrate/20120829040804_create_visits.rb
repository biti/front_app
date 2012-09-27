class CreateVisits < ActiveRecord::Migration
  def change
    create_table :visits do |t|
      t.string :ip
      t.integer :cdn
      t.references :region
      t.string :client_key
      t.string :session_id
      t.references :subscriber
      t.string :ref
      t.string :url
      t.integer :source
      t.integer :type
      t.string :content

      t.timestamps
    end
    add_index :visits, :region_id
    add_index :visits, :subscriber_id
  end
end
