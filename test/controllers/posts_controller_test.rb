require 'test_helper'

class PostsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    @post = posts(:one)
    sign_in users(:user)
  end

  test "should get index" do
    get posts_url
    assert_response :success
  end

  test "should get new" do
    get new_post_url
    assert_response :ok
  end

  test "should create post" do
    assert_difference('Post.count') do
      post posts_url, params: { post: { date: @post.date, rationale: @post.rationale } }
    end

    assert_redirected_to post_url(Post.last)
  end
end
