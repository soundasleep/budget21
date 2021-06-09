class Rule < ApplicationRecord
  belongs_to :category

  validates :category, presence: true

  validate :needs_at_least_one_matcher

  private

  def needs_at_least_one_matcher
    if [description_matches, reference_matches, particular_matches, code_matches, any_matches].join("").strip.blank?
      errors.add(:matchers, "needs at least one matcher set")
    end
  end
end
