class CategoriesController < ApplicationController
  before_action :authenticate_user!
  # before_action :set_user
  # before_action :set_category, only:  %i[show edit update destroy]
  # load_and_authorize_resource

  def index
    @user = current_user
    @categories = @user.categories.includes(:author)
  end

  def show
    @user = current_user
    @category = @user.categories.includes(:author).find(params[:id])
    @activities = @category.activities
  end

  def new
    @category = Category.new
    # @category = Category.new(author: current_user)
  end

  def create
    @category = current_user.categories.build(category_params)

    respond_to do |format|
      if @category.save
        format.html { redirect_to user_categories_path(current_user), notice: 'Category was successfully created.' }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @category.destroy

    respond_to do |format|
      format.html { redirect_to user_categories_path(current_user), notice: 'Category was successfully destroyed.' }
    end
  end

  private

  def set_category
    @category = @user.categories.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name, :icon)
  end
end
