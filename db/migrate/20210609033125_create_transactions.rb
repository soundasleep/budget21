class CreateTransactions < ActiveRecord::Migration[5.1]
  def change
    create_table :transactions do |t|
      t.integer :account_id, null: false

      t.timestamp :date, null: false
      t.string :description
      t.string :source_code
      t.string :tp_ref
      t.string :tp_part
      t.string :tp_code
      t.string :op_ref
      t.string :op_code
      t.string :op_name
      t.string :op_bank_account
      t.decimal :amount, null: false, precision: 7 + 2, scale: 2

      t.timestamps
    end

    add_index :transactions, :account_id
  end
end
