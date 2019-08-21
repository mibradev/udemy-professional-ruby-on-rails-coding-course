# frozen_string_literal: true

require "test_helper"

class UserTest < ActiveSupport::TestCase
  def setup
    @user = users(:user)
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "should not be admin" do
    assert_not User.new.admin?
  end

  test "should have first name" do
    @user.first_name = nil
    assert_not @user.valid?
  end

  test "should have last name" do
    @user.last_name = nil
    assert_not @user.valid?
  end

  test "should have full name" do
    assert_equal "#{@user.first_name} #{@user.last_name}", @user.full_name
  end

  test "should have phone" do
    @user.phone = nil
    assert_not @user.valid?
    assert_includes @user.errors.messages[:phone], I18n.t("errors.messages.wrong_length.other", count: 10)
    assert_includes @user.errors.messages[:phone], I18n.t("errors.messages.not_a_number")
  end
end
