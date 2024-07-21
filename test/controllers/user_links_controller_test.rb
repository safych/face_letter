require 'test_helper'

class UserLinksControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @user = users(:one)
    sign_in @user
  end

  test "should create user link" do
    post user_links_url, params: { user_link: { url: "https://coinmarketcap.com/uk/" } }
    assert_redirected_to profile_path
    follow_redirect!
    assert_equal flash[:done], I18n.t("services.user_link_creator.user_link_successful_created")
  end

  test "should not create user link exceeding the limit" do
    post user_links_url, params: { user_link: { url: "https://coinmarketcap.com/uk/" } }
    post user_links_url, params: { user_link: { url: "https://coinmarketcap.com/uk/" } }
    assert_redirected_to profile_path
    follow_redirect!
    puts flash[:done]
    assert_equal flash[:error], I18n.t("services.user_link_creator.error_limit_user_links")
  end

  test "should destroy user link" do
    user_link = user_links(:one)
    delete user_link_url(user_link)
    assert_redirected_to profile_path
    follow_redirect!
    assert_equal flash[:done], I18n.t("services.user_link_destroyer.user_link_successful_destroyed")
  end

  test "should update user link" do
    user_link = user_links(:one)
    patch user_link_url(user_link), params: { user_link: { url: "https://blog.jetbrains.com/kotlin/" } }
    assert_redirected_to profile_path
    follow_redirect!
    assert_equal flash[:done], I18n.t("services.user_link_updater.user_link_successful_updated")
    user_link.reload
    assert_equal "https://blog.jetbrains.com/kotlin/", user_link.url
  end
end