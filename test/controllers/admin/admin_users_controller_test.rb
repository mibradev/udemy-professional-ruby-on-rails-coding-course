# frozen_string_literal: true

require "test_helper"

module Admin
  class AdminUsersControllerTest < ActionDispatch::IntegrationTest
    include Devise::Test::IntegrationHelpers

    test "user should not get index" do
      sign_in users(:user)
      get admin_admin_users_url
      assert_redirected_to root_url
    end

    test "admin should get index" do
      sign_in admin_users(:admin)
      get admin_admin_users_url
      assert_response :success
    end
  end
end
