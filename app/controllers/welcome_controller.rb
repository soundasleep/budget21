class WelcomeController < ApplicationController
  def index
    @transactions = Transaction.all.order(date: :desc).left_outer_joins(:cached_category).left_outer_joins(:cached_rule).includes(:cached_category).includes(:cached_rule)
    if params[:category]
      @transactions = @transactions.where(cached_category: Category.find(params[:category]))
    end
    if params[:from]
      @transactions = @transactions.where('date >= ?', params[:from].to_date)
    end
    if params[:to]
      @transactions = @transactions.where('date < ?', params[:to].to_date)
    end
    if params[:uncategorised]
      @transactions = @transactions.where(cached_category: nil).limit(10)
      @transactions.each do |txn|
        if txn.calculated_category
          txn.update!({
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
    @method = :beginning_of_week
    @method_end = :end_of_week
    @title = "Week"
  end

  def months
    @transactions = Transaction.all.order(date: :desc).left_outer_joins(:cached_category).left_outer_joins(:cached_rule).includes(:cached_category).includes(:cached_rule)
    @categories = Category.all
    @method = :beginning_of_month
    @method_end = :end_of_month
    @title = "Month"
    render "weeks"
  end

  private

  helper_method :regexpise
  def regexpise(s)
    # I don't want to Regexp.escape() because that changes spaces to `\ `
    s.gsub("*", "\\*").gsub("+", "\\+").strip.downcase
  end
end
