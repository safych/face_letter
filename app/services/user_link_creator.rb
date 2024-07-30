class UserLinkCreator
  attr_reader :params, :user, :message

  def initialize(params, user)
    @params = params
    @user = user
    @message = Hash.new
  end

  def call
    check_user_links_count
  end

  private

  def check_user_links_count
    if @user.user_link.count > 10
      @message[:error] = I18n.t("services.user_link_creator.error_limit_user_links")
    else
      create
    end
  end

  def create
    if UserLink.new(url: @params[:url], user_id: @user.id).save
      @message[:done] = I18n.t("services.user_link_creator.user_link_successful_created")
    else
      @message[:error] = I18n.t("services.user_link_creator.user_link_did_not_create")
    end
  end
end