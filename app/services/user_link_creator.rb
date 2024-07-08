class UserLinkCreator
  attr_reader :params, :user
  attr_accessor :message

  def initialize(params, user)
    @params = params
    @user = user
    @message = Hash.new
  end

  def call
    create
  end

  private

  def create
    if @user.valid_password?(@params[:password])
      if UserLink.new(url: @params[:url], user_id: @user.id).save
        @message[:done] = I18n.t("services.user_link_creator.user_link_successful_created")
      else
        @message[:error] = I18n.t("services.user_link_creator.user_link_did_not_create")
      end
    else
      @message[:error] = I18n.t("services.user_link_creator.password_not_correct")
    end
  end
end