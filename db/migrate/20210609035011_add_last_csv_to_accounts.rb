class AddLastCsvToAccounts < ActiveRecord::Migration[5.1]
  def change
    add_column :accounts, :last_csv, :string
  end
end
