class HomeController < ApplicationController
  def index
    @users = User.select(:name, :surname, :id).page(permitted_params[:page])
  end

  private

  def permitted_params
    params.permit(:page)
  end
end