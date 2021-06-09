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

  def combined_any
    [date, description, source_code, tp_ref, tp_part, tp_code, op_ref, op_code, op_name, op_bank_account, amount].uniq.join(" ")
  end

  def calculated_rule(rules = Rule.all)
    @calculated_rule ||= rules.find do |rule|
        ((description || op_name) && !rule.description_matches.blank? && "#{description} #{op_name}".match?(regexp(rule.description_matches))) ||
        (combined_reference && !rule.reference_matches.blank? && combined_reference.match?(regexp(rule.reference_matches))) ||
        (combined_particulars && !rule.particular_matches.blank? && combined_particulars.match?(regexp(rule.particular_matches))) ||
        (combined_code && !rule.code_matches.blank? && combined_code.match?(regexp(rule.code_matches))) ||
        (combined_any && !rule.any_matches.blank? && combined_any.match?(regexp(rule.any_matches)))
      end
  end

  def calculated_category(rules = Rule.all)
    @calculated_category ||= calculated_rule(rules)&.category
  end

  def regexp(s)
    Regexp.new(s, Regexp::IGNORECASE | Regexp::MULTILINE)
  end
end
