class ModifySubscriberDetailsAndAuthorizations < ActiveRecord::Migration
  def change
    rename_column :subscriber_details, :rank_expire_at, :expired_at
    rename_column :authorizations, :expire_at, :expired_at
  end
end
