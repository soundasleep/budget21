class Category < ApplicationRecord
  has_many :rules, dependent: :destroy

  validates :color, presence: true
end
