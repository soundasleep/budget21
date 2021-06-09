class DropOpNameMatchesFromRules < ActiveRecord::Migration[5.1]
  def change
    remove_column :rules, :op_name_matches, :string
  end
end
