class AddAnyMatchesToRules < ActiveRecord::Migration[5.1]
  def change
    add_column :rules, :any_matches, :string
  end
end
