class ActivitiesController < ApplicationController
  def index
    @user = current_user
    @category = Category.find(params[:category_id])
    @activities = @category.activities
  end

  def show
    @activity = Activity.includes(:author, :category).find(params[:id])
    @categories = @activity.categories

    respond_to do |format|
      format.html { render :show }
    end
  end

  def new
    @category = Category.find(params[:category_id])
    @activity = Activity.new
  end

  def create
    @category = Category.find(params[:category_id])
    @activity = @category.activities.build(activity_params)
    @activity.author = current_user

    respond_to do |format|
      if @activity.save
        format.html { redirect_to user_category_activities_path(current_user, @category), notice: 'Transaction was successfully created.' }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  private

  def set_activity
    @activity = Activity.includes(:author, :categories).find(params[:id])
  end

  def activity_params
    params.require(:activity).permit(:name, :amount, :category_id)
  end
end
