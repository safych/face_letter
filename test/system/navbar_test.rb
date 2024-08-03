require 'application_system_test_case'

class NavbarTest < ApplicationSystemTestCase
  test "verificate header without auth" do
    visit root_path
    assert_selector "a", text: I18n.t("views.layouts.application.home")
    assert_selector "a", text: I18n.t("views.users.sessions.new.log_in")
    assert_selector "a", text: I18n.t("views.users.registrations.new.sign_up")
  end

  test "click on sign in" do
    visit root_path
    click_on I18n.t("views.layouts.application.log_in")
    assert_selector "h2", text: I18n.t("views.users.sessions.new.log_in")
  end

  test "click on sign up" do
    visit root_path
    click_on I18n.t("views.layouts.application.sign_up")
    assert_selector "h2", text: I18n.t("views.users.registrations.new.sign_up")
  end

  test "verificate header with auth" do
    user = users(:one)
    sign_in user

    visit root_path
    assert_selector "a", text: I18n.t("views.layouts.application.home")
    click_on "userDropdown"
    assert_selector "a", text: I18n.t("views.layouts.application.profile")
    assert_selector "a", text: I18n.t("views.layouts.application.log_out")
  end

  test "click on profile" do
    user = users(:one)
    sign_in user

    visit root_path
    assert_selector "a", text: I18n.t("views.layouts.application.home")
    click_on "userDropdown"
    click_on I18n.t("views.layouts.application.profile")
    assert_selector "a", text: I18n.t("views.profiles.show.show_all_user_links")
  end

  test "click on log_out" do
    user = users(:one)
    sign_in user

    visit root_path
    assert_selector "a", text: I18n.t("views.layouts.application.home")
    click_on "userDropdown"
    click_on I18n.t("views.layouts.application.log_out")
    assert_selector "a", text: I18n.t("views.users.sessions.new.log_in")
    assert_selector "a", text: I18n.t("views.users.registrations.new.sign_up")
  end
end