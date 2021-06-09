class CategoriesController < ApplicationController
  def index
    @categories = Category.all
  end

  def show
    @category = Category.find(params[:id])
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(update_params)
    if @category.save
      flash[:notice] = "Created new category."
      redirect_to @category
    else
      flash[:errors] = @category.errors.full_messages
      render "new"
    end
  end

  def edit
    @category = Category.find(params[:id])
  end

  def update
    @category = Category.find(params[:id])
    @category.assign_attributes(update_params)
    if @category.save
      flash[:notice] = "Updated category."
      redirect_to @category
    else
      flash[:errors] = @category.errors.full_messages
      render "edit"
    end
  end

  private

  def update_params
    params.require(:category).permit(:title)
  end
end
