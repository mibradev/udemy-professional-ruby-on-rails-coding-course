require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = users(:user)
  end

  test "should not be admin" do
    assert_nil User.new.type
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "should have first name" do
    @user.first_name = nil
    assert_not @user.valid?
  end

  test "should have last name" do
    @user.last_name = nil
    assert_not @user.valid?
  end
end
