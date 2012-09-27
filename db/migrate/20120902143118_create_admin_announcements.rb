class CreateAdminAnnouncements < ActiveRecord::Migration
  def change
    create_table :admin_announcements do |t|
      t.string :title, :null => false
      t.string :content, :null => false

      t.timestamps
    end
  end
end
