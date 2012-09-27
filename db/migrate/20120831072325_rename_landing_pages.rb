class RenameLandingPages < ActiveRecord::Migration
  def change
    rename_table :landing_pages, :admin_landing_pages
  end
end
