class CreateCreditTransactions < ActiveRecord::Migration
  def change
    create_table :credit_transactions do |t|
      t.references :credit, :null => false
      t.references :document
      t.integer :realm, :null => false
      t.decimal :amount, :precision => 10, :scale => 2, :null => false

      t.timestamps
    end
    add_index :credit_transactions, :credit_id
    add_index :credit_transactions, :document_id
  end
end
