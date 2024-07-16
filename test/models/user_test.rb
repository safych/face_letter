require "test_helper"

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(name: "af", surname: "fdg", password: "1Fdses2!", email: "test@gmail.com")
  end

  test "valid user" do
    assert @user.valid?
  end

  test 'invalid without password' do
    @user.password = nil
    refute @user.valid?, 'user is valid without a password'
    assert_not_nil @user.errors[:password], 'no validation error for password present'
  end

  test 'invalid with incorrect name and surname length' do
    @user.name = 'sdfgggggggggggggggggggggggggggggvtrvrtgrrrrrrrrrrrrrrrrrrrrrrrr'
    @user.surname = 'sdfgggggggggggggggggggggggggggggvtrvrtgrrrrrrrrrrrrrrrrrrrrrr'
    refute @user.valid?, 'user is valid with incorrect name and surnamme length'
    assert_includes @user.errors[:name], "is too long (maximum is 50 characters)", "Name length error message not found"
    assert_includes @user.errors[:surname], "is too long (maximum is 50 characters)", "Surname length error message not found"
  end

  test 'invalid email format' do
    @user.email = "123@frrfer"
    refute @user.valid?, 'user is valid with invalid email format'
    assert_includes @user.errors[:email], "is invalid", "Email format error message not found"
  end
end
