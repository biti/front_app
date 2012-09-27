class CreateLandingPages < ActiveRecord::Migration
  def change
    create_table :landing_pages do |t|
      t.string :domain
      t.references :region
      t.string :background_image, :null => false

      t.timestamps
    end
    add_index :landing_pages, :domain
    add_index :landing_pages, [ :domain, :background_image ], :unique => true
    add_index :landing_pages, :region_id
  end
end
