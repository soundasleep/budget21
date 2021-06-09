class AddOrderToCategory < ActiveRecord::Migration[5.1]
  def change
    add_column :categories, :order, :integer, null: false, default: 0
  end
end
