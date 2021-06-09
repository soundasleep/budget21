class RulesController < ApplicationController
  def index
    @rules = Rule.all
  end

  def new
    @rule = Rule.new
  end

  def create
    @rule = Rule.new(update_params)
    if @rule.save
      flash[:notice] = "Created new rule."
      if params[:redirect_to] == "root_path"
        redirect_to root_path
      else
        redirect_to rules_path
      end
    else
      flash[:errors] = @rule.errors.full_messages
      render "new"
    end
  end

  def edit
    @rule = Rule.find(params[:id])
  end

  def update
    @rule = Rule.find(params[:id])
    @rule.assign_attributes(update_params)
    if @rule.save
      flash[:notice] = "Updated rule."
      redirect_to rules_path
    else
      flash[:errors] = @rule.errors.full_messages
      render "edit"
    end
  end

  def destroy
    @rule = Rule.find(params[:id])

    @rule.destroy!
    flash[:notice] = "Deleted rule."

    redirect_to rules_path
  end

  private

  def update_params
    params.require(:rule).permit(:description_matches, :reference_matches,
        :particular_matches, :code_matches, :any_matches, :category_id)
  end
end
