require 'test_helper'

class AdminUserTest < ActiveSupport::TestCase
  test "should be admin" do
    assert AdminUser.new.admin?
  end
end
