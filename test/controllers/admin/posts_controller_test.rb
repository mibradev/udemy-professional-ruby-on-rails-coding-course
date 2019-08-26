# frozen_string_literal: true

require "test_helper"

module Admin
  class PostsControllerTest < ActionDispatch::IntegrationTest
    include Devise::Test::IntegrationHelpers

    test "employee should not get index" do
      sign_in employee_users(:ahmad)
      get admin_root_url
      assert_redirected_to root_url

      get admin_posts_url
      assert_redirected_to root_url
    end

    test "admin should get index" do
      sign_in admin_users(:admin)
      get admin_root_url
      assert_response :success

      get admin_posts_url
      assert_response :success
    end
  end
end
