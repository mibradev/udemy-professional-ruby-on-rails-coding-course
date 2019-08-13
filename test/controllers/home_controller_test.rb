require 'test_helper'

class HomeControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    sign_in users(:user)
  end

  test "should get index" do
    get root_url
    assert_response :success
  end
end
