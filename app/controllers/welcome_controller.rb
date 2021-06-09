class WelcomeController < ApplicationController
  def index
    @transactions = Transaction.all.order(date: :desc).left_outer_joins(:cached_category).left_outer_joins(:cached_rule).includes(:cached_category).includes(:cached_rule)
    if params[:uncategorised]
      @transactions = @transactions.where(cached_category: nil).limit(10)
      @transactions.each do |txn|
        if txn.calculated_category
          txn.update_attributes!({
            cached_category: txn.calculated_category,
            cached_rule: txn.calculated_rule,
          })
        end
      end
    end
    @categories = Category.all
  end

  def weeks
    @transactions = Transaction.all.order(date: :desc).left_outer_joins(:cached_category).left_outer_joins(:cached_rule).includes(:cached_category).includes(:cached_rule)
    @categories = Category.all
  end

  private

  helper_method :regexpise
  def regexpise(s)
    # I don't want to Regexp.escape() because that changes spaces to `\ `
    s.gsub("*", "\\*").gsub("+", "\\+").strip.downcase
  end
end
