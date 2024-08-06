require 'application_system_test_case'

class ProfilesTest < ApplicationSystemTestCase
  setup do
    @user = users(:one)
    sign_in @user
  end

  test "update  name surname" do
    visit profile_path

    click_on I18n.t("views.profiles.show.show_user_name_surname_update_form")

    fill_in I18n.t("views.profiles.show.name"),	with: "sometext"
    fill_in I18n.t("views.profiles.show.surname"), with: "hello"

    click_on I18n.t("views.profiles.show.update")
    assert_selector "div", text: I18n.t("services.user_updater.user_data_successful_updated")
  end

  test "display all user links" do
    visit profile_path

    click_on I18n.t("views.profiles.show.show_all_user_links")
    assert_selector "h4", text: user_links(:one).url
  end

  test "create url" do
    visit profile_path

    click_on I18n.t("views.profiles.show.show_user_link_create_form")

    fill_in I18n.t("views.profiles.show.url"), with: Faker::Internet.url(scheme: 'https')

    click_on I18n.t("views.profiles.show.add_url")
    assert_selector "div", text: I18n.t("services.user_link_creator.user_link_successful_created")
  end

  test "try to create url with incorrect format" do
    visit profile_path

    click_on I18n.t("views.profiles.show.show_user_link_create_form")

    fill_in I18n.t("views.profiles.show.url"), with: Faker::Internet.url

    click_on I18n.t("views.profiles.show.add_url")
    assert_selector "div", text: I18n.t("validators.incorrect_format")
  end

  test "update url" do
    visit profile_path

    click_on I18n.t("views.profiles.show.show_all_user_links")
    
    click_on(id: "update user-link-#{user_links(:one).id}")
    fill_in "link-update-field-#{user_links(:one).id}", with: Faker::Internet.url(scheme: 'https')
    find('input[name="commit"]').click
    assert_selector "div", text: I18n.t("services.user_link_updater.user_link_successful_updated")
  end

  test "try to update url with incorrect new-url format" do
    visit profile_path

    click_on I18n.t("views.profiles.show.show_all_user_links")
    
    click_on(id: "update user-link-#{user_links(:one).id}")
    fill_in "link-update-field-#{user_links(:one).id}", with: Faker::Internet.url
    find('input[name="commit"]').click
    assert_selector "div", text: I18n.t("validators.incorrect_format")
  end

  test "update avatar" do
    avatar_path = Rails.root.join("test/fixtures/files/photo_2024-07-23_11-25-48.jpg")

    visit profile_path

    click_on I18n.t("views.profiles.show.show_user_avatar_update_form")

    attach_file(avatar_path) do
      find(:label, I18n.t("views.profiles.show.avatar")).click
    end
    find('input[name="commit"]').click
    assert_selector "div", text: I18n.t("services.user_updater.user_avatar_successful_updated")
  end

  test "update password" do
    visit profile_path

    click_on I18n.t("views.profiles.show.show_user_password_update_form")

    fill_in "current-password-update-password-field", with: "Password123!"
    fill_in "new-password-update-password-field", with: "NewPassword123!"
    find('input[name="commit"]').click
    assert_selector "h2", text: I18n.t("views.users.sessions.new.log_in")
  end

  test "try to update password with incorrect new-password format" do
    visit profile_path

    click_on I18n.t("views.profiles.show.show_user_password_update_form")

    fill_in "current-password-update-password-field", with: "Password123!"
    fill_in "new-password-update-password-field", with: "erg2"
    find('input[name="commit"]').click
    assert_selector "div", text: "is too short (minimum is 8 characters)"
  end

  test "update email" do
    visit profile_path

    click_on I18n.t("views.profiles.show.user_email_update_form")

    fill_in I18n.t("views.profiles.show.current_password"), with: "Password123!"
    find('input[name="commit"]').click
    
    visit edit_email_path

    @user.reload
    fill_in "new-email", with: Faker::Internet.email
    fill_in "token-update-email", with: @user.update_email_token
    find('input[name="commit"]').click

    assert_selector "h2", text: I18n.t("views.users.sessions.new.log_in")
  end

  test "try to update email with input incorrect current token" do
    visit profile_path

    click_on I18n.t("views.profiles.show.user_email_update_form")

    fill_in I18n.t("views.profiles.show.current_password"), with: "Password123!"
    find('input[name="commit"]').click
    
    visit edit_email_path

    @user.reload
    fill_in "new-email", with: Faker::Internet.email
    fill_in "token-update-email", with: "token"
    find('input[name="commit"]').click

    assert_selector "div", text: I18n.t("services.email_updater.not_correct_token_or_time")
  end

  test "try to update email with input incorrect current password" do
    visit profile_path

    click_on I18n.t("views.profiles.show.user_email_update_form")

    fill_in I18n.t("views.profiles.show.current_password"), with: "Pass"
    find('input[name="commit"]').click
    assert_selector "div", text: I18n.t("services.user_updater.not_correct_password")
  end
end