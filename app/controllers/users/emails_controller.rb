module Users
  class EmailsController < ApplicationController
    before_action :authenticate_user!

    def edit
    end

    def update
    end
  end
end