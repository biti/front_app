class CreateOnlinePayLogs < ActiveRecord::Migration
  def change
    create_table :online_pay_logs do |t|
      t.string  :notify_id
      t.integer :pay_id
      t.string :channel
      t.string :channel_no
      t.decimal :paid,     :precision => 10, :scale => 0, :default => 0, :null => false
      t.datetime :notify_time
      t.string :status
      t.string :failure_reason

      t.timestamps
    end
    
    add_index :online_pay_logs, :pay_id
  end
end
