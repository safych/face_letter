require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @user = users(:one)
    sign_in @user
  end

  test "should update user's name and surname" do
    patch user_url(@user), params: { user: { name: "NewName", surname: "NewSurname" } }
    assert_redirected_to profile_path
    follow_redirect!
    assert_equal flash[:done], I18n.t("services.user_updater.user_data_successful_updated")
    @user.reload
    assert_equal "NewName", @user.name
    assert_equal "NewSurname", @user.surname
  end

  test "should not update user with wrong password" do
    patch user_url(@user), params: { user: { new_password: "Newpass123!", current_password: "wrongpassword" } }
    assert_redirected_to profile_path
    follow_redirect!
    assert_equal flash[:error], I18n.t("services.user_updater.not_correct_password")
    @user.reload
    assert_not @user.valid_password?("Newpass123!")
  end

  test "should update user's password" do
    patch user_url(@user), params: { user: { new_password: "Newpass123!!!", current_password: "Password123!" } }
    assert_redirected_to profile_path
    follow_redirect!
    assert_equal flash[:done], I18n.t("services.user_updater.user_password_successful_updated")
    @user.reload
    assert_equal @user.valid_password?("Newpass123!!!"), true
  end

  test "should update user's avatar" do
    avatar_path = Rails.root.join("test/fixtures/files/photo_2024-07-23_11-25-48.jpg")
    patch user_url(@user), params: { user: { avatar: fixture_file_upload(avatar_path, "image/png") } }
    assert_redirected_to profile_path
    follow_redirect!
    assert_equal flash[:done], I18n.t("services.user_updater.user_avatar_successful_updated")
  end
end