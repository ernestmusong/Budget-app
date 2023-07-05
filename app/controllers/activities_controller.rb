class ActivitiesController < ApplicationController
    before_action :set_activity, only: %i[show edit update destroy]

  def show
    @activity = Activity.includes(:author, :category).find(params[:id])
    @categories = @activity.categories

    respond_to do |format|
      format.html { render :show }
    end
  end

  def new
    @recipe = Recipe.new
  end

  def edit; end

  def create
    @recipe = current_user.recipes.build(recipe_params)

    respond_to do |format|
      if @recipe.save
        format.html { redirect_to user_recipes_path(current_user), notice: 'Transaction was successfully created.' }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @recipe.update(recipe_params)
        format.html { redirect_to user_recipes_path(current_user), notice: 'Transaction was successfully updated.' }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @recipe.destroy

    respond_to do |format|
      format.html { redirect_to user_recipes_path(current_user), notice: 'Transaction was successfully destroyed.' }
    end
  end

  private

  def set_activity
    @activity = Activity.includes(:author).find(params[:id])
  end

  def activity_params
    params.require(:activity).permit(:name, :amount, :categories)
  end
end
