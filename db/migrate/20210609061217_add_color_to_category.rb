class AddColorToCategory < ActiveRecord::Migration[5.1]
  def change
    add_column :categories, :color, :string, null: false, default: "black"
  end
end
