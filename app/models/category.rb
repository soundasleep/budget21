class Category < ApplicationRecord
  has_many :rules, dependent: :destroy

  has_many :cached_transactions, class_name: "Transaction", foreign_key: :cached_category_id, dependent: :nullify

  validates :color, :order, presence: true

  default_scope { order(order: :desc) }
end
