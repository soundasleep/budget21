class CreateRules < ActiveRecord::Migration[5.1]
  def change
    create_table :rules do |t|
      t.integer :category_id, null: false

      t.string :description_matches
      t.string :reference_matches
      t.string :particular_matches
      t.string :code_matches
      t.string :op_name_matches

      t.timestamps
    end

    add_index :rules, :category_id
  end
end
