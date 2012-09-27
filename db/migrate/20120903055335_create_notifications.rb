class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.references :to, :null => false
      t.integer :type
      t.string :content, :null => false
      t.integer :state
      t.timestamp :marked_at

      t.timestamps
    end
    add_index :notifications, :to_id
  end
end
