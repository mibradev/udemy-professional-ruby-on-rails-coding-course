require 'test_helper'

class AdministrateControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  test "should get index" do
    sign_in admin_users(:admin)
    get admin_root_url
    assert_response :success
  end

  test "should not get index if not logged in" do
    get admin_root_url
    assert_redirected_to new_user_session_url
  end

  test "should not get index if not an admin" do
    sign_in users(:user)
    get admin_root_url
    assert_redirected_to root_url
  end
end
