class CreateRegions < ActiveRecord::Migration
  def change
    create_table :regions do |t|
      t.string :title, :null => false
      t.integer :level, :null => false
      t.references :parent

      t.timestamps
    end
    add_index :regions, :parent_id
  end
end
