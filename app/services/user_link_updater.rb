class UserLinkUpdater
  attr_reader :params, :current_user, :user_link
  attr_accessor :message

  def initialize(params, current_user, user_link)
    @params = params
    @current_user = current_user
    @user_link = user_link
    @message = Hash.new
  end

  def call
    update
  end

  private

  def update
    if @user_link.user == @current_user
      if @user_link.update(url: params[:url])
        @message[:done] = I18n.t("user_link_successful_updated")
      else
        @message[:error] = I18n.t("user_link_did_not_update")
      end
    else
      @message[:error] = I18n.t("not_correct_user")
    end
  end
end