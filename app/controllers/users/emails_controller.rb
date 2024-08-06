module Users
  class EmailsController < ApplicationController
    before_action :authenticate_user!

    def edit
    end

    def update
      email_updater = EmailUpdater.new(user_params, current_user)
      email_updater.call
      if email_updater.message[:done]
        flash[:done] = email_updater.message[:done]
        sign_out(current_user)
        redirect_to new_user_session_path
      elsif email_updater.message[:error]
        flash[:error] = email_updater.message[:error]
        redirect_to edit_email_path
      end
    end

    private

    def user_params
      params.require(:user).permit(:token, :new_email)
    end
  end
end