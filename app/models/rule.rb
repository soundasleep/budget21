class Rule < ApplicationRecord
  belongs_to :category

  has_many :cached_transactions, class_name: "Transaction", foreign_key: :cached_rule_id, dependent: :nullify

  validates :category, presence: true

  validate :needs_at_least_one_matcher

  private

  def needs_at_least_one_matcher
    if [description_matches, reference_matches, particular_matches, code_matches, any_matches].join("").strip.blank?
      errors.add(:matchers, "needs at least one matcher set")
    end
  end
end
