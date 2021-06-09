class Account < ApplicationRecord
  has_many :transactions, dependent: :destroy

  mount_uploader :last_csv, CsvUploader
end
