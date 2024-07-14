require "test_helper"

class UserMailerTest < ActionMailer::TestCase
  test "update_email" do
    email = "vova@co.co"
    token = "23f2fd"
    mail = UserMailer.update_email(email, token)

    assert_emails 1 do
      mail.deliver_now
    end

    assert_equal I18n.t("mailers.user_mailer.token_to_changed_email"), mail.subject
    assert_equal [email], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match token, mail.body.encoded
  end
end
