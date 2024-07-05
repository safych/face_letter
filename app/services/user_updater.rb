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
      @message[:error] = I18n.t("not_correct_user_or_password")
    end
  end

  def update
    if @params[:name] || @params[:surname]
      update_name_surname
    elsif @params[:new_password]
      update_password
    elsif @params[:email]
      update_email
    end
  end

  def update_name_surname
    if @user.update(name: @params[:name], surname: @params[:surname])
      @message[:done] = I18n.t("user_data_successful_updated")
    else
      @message[:error] = I18n.t("user_data_did_not_update")
    end
  end

  def update_password
    if @user.update(password: @params[:new_password])
      @message[:done] = I18n.t("user_password_successful_updated")
    else
      @message[:error] = I18n.t("user_password_did_not_update")
    end
  end

  def update_email

  end
end