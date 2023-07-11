class ActivitiesController < ApplicationController
  def index
    @user = current_user
    @category = Category.find(params[:category_id])
    @activities = @category.activities
  end

  def show
    @user = current_user
    @category = Category.find(params[:category_id])
    @activity = Activity.includes(:author, :category).find(params[:id])
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
        format.html do
          redirect_to user_category_activities_path(current_user, @category),
                      notice: 'Transaction was successfully created.'
        end
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @user = current_user
    @category = Category.find(params[:category_id])
    @activity = Activity.includes(:author, :category).find(params[:id])
    @activity.destroy

    respond_to do |format|
      format.html do
        redirect_to user_category_activities_path(@user, @category), notice: 'Transaction was successfully deleted!'
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
