class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user

  def update
    user_updater = UserUpdater.new(user_params, current_user, @user)
    user_updater.call
    flash[:done] = user_updater.message[:done]
    flash[:error] = user_updater.message[:error]
    redirect_to profile_path
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:new_password, :current_password, :name, :surname, :avatar)
  end
end