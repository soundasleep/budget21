class WelcomeController < ApplicationController
  def index
    @transactions = Transaction.all.order(date: :desc)
    @categories = Category.all
  end
end
