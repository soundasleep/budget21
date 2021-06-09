class AddOpPartToTransaction < ActiveRecord::Migration[5.1]
  def change
    add_column :transactions, :op_part, :string
  end
end
