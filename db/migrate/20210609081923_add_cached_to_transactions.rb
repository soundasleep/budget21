class AddCachedToTransactions < ActiveRecord::Migration[5.1]
  def change
    add_column :transactions, :cached_category_id, :integer, null: true
    add_column :transactions, :cached_rule_id, :integer, null: true

    add_index :transactions, :cached_category_id
    add_index :transactions, :cached_rule_id
  end
end
