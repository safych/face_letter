require 'application_system_test_case'

class RegistrationsTest < ApplicationSystemTestCase
  test "successful registration" do
    visit new_user_registration_path

    fill_in I18n.t("views.users.registrations.new.email"), with: Faker::Internet.email
    fill_in I18n.t("views.users.registrations.new.name"), with: "Name"
    fill_in I18n.t("views.users.registrations.new.surname"), with: "Surname"
    fill_in I18n.t("views.users.registrations.new.password"), with: "Password123!"
    fill_in id: "user_password_confirmation", with: "Password123!"

    find('input[name="commit"]').click

    assert_selector "a", id: "userDropdown"
  end

  test "try to sign up with existing email" do
    visit new_user_registration_path

    fill_in I18n.t("views.users.registrations.new.email"), with: users(:one).email
    fill_in I18n.t("views.users.registrations.new.name"), with: "Name"
    fill_in I18n.t("views.users.registrations.new.surname"), with: "Surname"
    fill_in I18n.t("views.users.registrations.new.password"), with: "Password123!"
    fill_in id: "user_password_confirmation", with: "Password123!"

    find('input[name="commit"]').click

    assert_selector "div", text: "Email has already been taken"
    assert_selector "h2", text: I18n.t("views.users.registrations.new.sign_up")
  end

  test "try to sign up with incorrect password format" do
    visit new_user_registration_path

    fill_in I18n.t("views.users.registrations.new.email"), with: Faker::Internet.email
    fill_in I18n.t("views.users.registrations.new.name"), with: "Name"
    fill_in I18n.t("views.users.registrations.new.surname"), with: "Surname"
    fill_in I18n.t("views.users.registrations.new.password"), with: "ddfg1"
    fill_in id: "user_password_confirmation", with: "ddfg1"

    find('input[name="commit"]').click

    assert_selector "div", text: "is too short (minimum is 6 characters)"
    assert_selector "h2", text: I18n.t("views.users.registrations.new.sign_up")
  end
end
