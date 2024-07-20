require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @user = users(:one)
    sign_in @user
  end

  test "should update user" do
    patch user_url(@user), params: { user: { name: "NewName", surname: "NewSurname" } }
    assert_redirected_to profile_path
    follow_redirect!
    assert_not flash[:done].empty?
    @user.reload
    assert_equal "NewName", @user.name
    assert_equal "NewSurname", @user.surname
  end

  test "should not update user with wrong password" do
    patch user_url(@user), params: { user: { new_password: "NewPassword", current_password: "wrongpassword" } }
    assert_redirected_to profile_path
    follow_redirect!
    assert_not flash[:error].empty?
    @user.reload
    assert_not @user.valid_password?("NewPassword")
  end
end