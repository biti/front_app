class ModifySubscribers2 < ActiveRecord::Migration
  def change
    change_table :subscribers do |t|
      t.rename :sigil, :salt
    end
  end
end
