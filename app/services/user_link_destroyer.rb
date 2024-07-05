class UserLinkDestroyer
  attr_reader :user_link, :current_user
  attr_accessor :message

  def initialize(user_link, current_user)
    @user_link = user_link
    @current_user = current_user
    @message = Hash.new
  end

  def call
    destroy
  end

  private

  def destroy
    if @user_link.user == @current_user
      if @user_link.destroy
        @message[:done] = I18n.t("user_link_successful_destroyed")
      else
        @message[:error] = I18n.t("user_link_did_not_destroy")
      end
    else
      @message[:error] = I18n.t("not_correct_user")
    end
  end
end