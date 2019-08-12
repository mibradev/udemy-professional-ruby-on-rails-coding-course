require 'test_helper'

class AdminUserTest < ActiveSupport::TestCase
  test "should be admin" do
    assert_equal 'AdminUser', AdminUser.new.type
  end
end
