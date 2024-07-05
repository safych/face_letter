class ProfilesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user
  before_action :set_user_links

  def show
    @user_link = UserLink.new
  end

  private

  def set_user
    @user = current_user
  end

  def set_user_links
    @user_links = UserLink.where(user_id: current_user.id)
  end
end