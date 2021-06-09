class Category < ApplicationRecord
  has_many :rules, dependent: :destroy

  validates :color, :order, presence: true

  default_scope { order(order: :desc) }
end
