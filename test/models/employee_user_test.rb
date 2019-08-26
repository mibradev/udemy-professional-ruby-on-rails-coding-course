# frozen_string_literal: true

require "test_helper"

class EmployeeUserTest < ActiveSupport::TestCase
  test "should be employee" do
    assert EmployeeUser.new.employee?
  end
end
