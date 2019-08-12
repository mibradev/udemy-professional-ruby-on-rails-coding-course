require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "should not be admin" do
    assert_nil User.new.type
  end
end
