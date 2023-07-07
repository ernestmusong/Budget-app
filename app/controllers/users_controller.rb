class UsersController < ApplicationController
  def index; end

  def show
    @user = current_user
    @categories = @user.categories
  end

  def sign_out_user
    sign_out current_user
    redirect_to root_path
  end
end
