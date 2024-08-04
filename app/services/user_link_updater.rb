class UserLinkUpdater
  attr_reader :params, :current_user, :user_link, :message
 
  def initialize(params, current_user, user_link)
    @params = params
    @current_user = current_user
    @user_link = user_link
    @message = Hash.new
  end

  def call
    url_format_verification
  end

  private

  def url_format_verification
    url_validator = UrlValidator.new(@params[:url])
    unless url_validator.valid?
      url_validator.errors.full_messages.each do |message|
        @message[:error] = message
      end
    else
      update
    end
  end

  def update
    if @user_link.user == @current_user
      if @user_link.update(url: params[:url])
        @message[:done] = I18n.t("services.user_link_updater.user_link_successful_updated")
      else
        @message[:error] = I18n.t("services.user_link_updater.user_link_did_not_update")
      end
    else
      @message[:error] = I18n.t("services.user_link_updater.not_correct_user")
    end
  end
end