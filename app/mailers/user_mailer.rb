class UserMailer < ApplicationMailer
  def update_email(email, token)
    @email = email
    @token = token
    @url = edit_email_url
    mail(to: @email, subject: I18n.t("mailers.user_mailer.token_to_changed_email") )
  end
end
