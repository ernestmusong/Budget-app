class Users::SessionsController < Devise::SessionsController
  def destroy
    super
    flash[:notice] = 'You have been signed out.'
  end
end
