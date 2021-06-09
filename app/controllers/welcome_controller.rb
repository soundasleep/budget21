class WelcomeController < ApplicationController
  def index
    @transactions = Transaction.all.order(date: :desc)
    if params[:uncategorised]
      @transactions = @transactions.select { |txn| txn.calculated_category.nil? }
    end
    @categories = Category.all
  end

  def weeks
    @transactions = Transaction.all.order(date: :desc)
    @categories = Category.all
  end
end
