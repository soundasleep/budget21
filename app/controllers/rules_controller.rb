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
      redirect_to select_redirect_path
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
      redirect_to select_redirect_path
    else
      flash[:errors] = @rule.errors.full_messages
      render "edit"
    end
  end

  def destroy
    @rule = Rule.find(params[:id])

    Transaction.all.where(cached_rule: @rule).each do |txn|
      txn.update!({
        cached_rule: nil,
        cached_category: nil,
      })
    end

    @rule.destroy!
    flash[:notice] = "Deleted rule."

    redirect_to select_redirect_path
  end

  private

  def update_params
    params.require(:rule).permit(:description_matches, :reference_matches,
        :particular_matches, :code_matches, :any_matches, :category_id)
  end

  def select_redirect_path
    if params[:redirect_to] == "root_path"
      root_path
    elsif params[:redirect_to] == "uncategorised"
      root_path(uncategorised: true)
    else
      rules_path
    end
  end
end
