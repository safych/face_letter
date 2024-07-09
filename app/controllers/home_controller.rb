class HomeController < ApplicationController
  def index
    @users = User.select(User.attribute_names - ['encrypted_password']).page(permitted_params[:page])
  end

  private

  def permitted_params
    params.permit(:page)
  end
end