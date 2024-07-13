class UserUpdater
  attr_reader :params, :current_user
  attr_accessor :message

  def initialize(params, current_user, user)
    @params = params
    @current_user = current_user
    @user = user
    @message = Hash.new
  end

  def call
    user_verification
  end

  private

  def user_verification
    if @current_user == @user && @user.valid_password?(@params[:current_password])
      update
    else
      @message[:error] = I18n.t("services.user_updater.not_correct_user_or_password")
    end
  end

  def update
    if @params[:name] || @params[:surname]
      update_name_surname
    elsif @params[:new_password]
      update_password
    elsif @params[:avatar]
      update_avatar
    else
      send_letter_for_update_email
    end
  end

  def update_name_surname
    if @user.update(name: @params[:name], surname: @params[:surname])
      @message[:done] = I18n.t("services.user_updater.user_data_successful_updated")
    else
      @message[:error] = I18n.t("services.user_updater.user_data_did_not_update")
    end
  end

  def update_password
    if @user.update(password: @params[:new_password])
      @message[:done] = I18n.t("services.user_updater.user_password_successful_updated")
    else
      @message[:error] = I18n.t("services.user_updater.user_password_did_not_update")
    end
  end

  def send_letter_for_update_email
    @user.update_email_token = SecureRandom.hex(3)
    @user.update_email_token_sent_at = DateTime.now
    @user.save
    UserMailer.update_email(@user.email, @user.update_email_token).deliver_now
  end

  def update_avatar
    if @user.update(avatar: @params[:avatar])
      @message[:done] = I18n.t("services.user_updater.user_avatar_successful_updated")
    else
      @message[:error] = I18n.t("services.user_updater.user_avatar_did_not_update")
    end
  end
end