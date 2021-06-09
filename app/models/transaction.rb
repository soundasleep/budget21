class Transaction < ApplicationRecord
  belongs_to :account

  validates :account, :date, :amount, presence: true
  validates :amount, numericality: true

  def combined_reference
    [tp_ref, op_ref].uniq.join(" ")
  end

  def combined_particulars
    [tp_part, op_part].uniq.join(" ")
  end

  def combined_code
    [tp_code, op_code].uniq.join(" ")
  end
end
