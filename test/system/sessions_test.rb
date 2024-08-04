require 'application_system_test_case'

class SessionsTest < ApplicationSystemTestCase
  test "successful auth" do
    visit new_user_session_path

    fill_in I18n.t("views.users.sessions.new.email"), with: users(:one).email
    fill_in I18n.t("views.users.sessions.new.password"), with: "Password123!"

    click_on I18n.t("views.users.registrations.new.sign_up")
    assert_selector "a", id: "userDropdown"
  end

  test "try to auth with incorrect email" do
    visit new_user_session_path

    fill_in I18n.t("views.users.sessions.new.email"), with: "in@rg.ed"
    fill_in I18n.t("views.users.sessions.new.password"), with: "Password123!"

    click_on(class: "btn btn-primary")
    assert_selector "div[style='color:red;']", text: "Invalid Email or password."
  end

  test "try to auth with incorrect password" do
    visit new_user_session_path

    fill_in I18n.t("views.users.sessions.new.email"), with: users(:one).email
    fill_in I18n.t("views.users.sessions.new.password"), with: "incorrect password"

    click_on(class: "btn btn-primary")
    assert_selector "div[style='color:red;']", text: "Invalid Email or password."
  end
end