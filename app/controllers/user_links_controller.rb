class UserLinksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user_link, only: [:update, :destroy]

  def create
    user_link_creator = UserLinkCreator.new(user_link_params, current_user)
    user_link_creator.call
    flash[:done] = user_link_creator.message[:done]
    flash[:error] = user_link_creator.message[:error]
    redirect_to profile_path
  end

  def update
    user_link_updater = UserLinkUpdater.new(user_link_params, current_user, @user_link)
    user_link_updater.call
    flash[:done] = user_link_updater.message[:done]
    flash[:error] = user_link_updater.message[:error]
    redirect_to profile_path
  end

  def destroy
    user_link_destroyer = UserLinkDestroyer.new(@user_link, current_user)
    user_link_destroyer.call
    flash[:done] = user_link_destroyer.message[:done]
    flash[:error] = user_link_destroyer.message[:error]
    redirect_to profile_path
  end

  private

  def set_user_link
    @user_link = UserLink.find(params[:id])
  end

  def user_link_params
    params.require(:user_link).permit(:url, :password)
  end
end