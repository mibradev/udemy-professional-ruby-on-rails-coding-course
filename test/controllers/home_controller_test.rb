# frozen_string_literal: true

require "test_helper"

class HomeControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  test "employee should get index" do
    sign_in employee_users(:ahmad)
    get root_url
    assert_response :success
  end

  test "admin should get index" do
    sign_in admin_users(:admin)
    get root_url
    assert_response :success
  end
end
