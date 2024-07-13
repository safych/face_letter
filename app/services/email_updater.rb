class EmailUpdater
  attr_reader :user
  attr_accessor :message

  def initialize(params, user)
    @params = params
    @user = user
    @message = Hash.new
  end

  def call
    token_verification
  end

  private

  def token_verification
    user_date_time = @user.update_email_token_sent_at + 5.minute
    if @params[:token] == @user.update_email_token && user_date_time >= DateTime.now
      update
    else
      message[:error] = I18n.t("services.email_updater.not_correct_token_or_time")
    end
  end

  def update
    @user.email = @params[:new_email]
    @user.update_email_token = nil
    @user.update_email_token_sent_at = nil
    @user.save
    message[:done] = I18n.t("services.email_updater.user_email_successful_updated")
  end
end