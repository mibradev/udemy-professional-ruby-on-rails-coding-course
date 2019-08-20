# frozen_string_literal: true

require "test_helper"

class PostsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def post_params(post)
    { post: { overtime_request: post.overtime_request, date: post.date, rationale: post.rationale } }
  end

  test "admin should get index" do
    sign_in admin_users(:admin)
    get posts_url
    assert_response :success
  end

  test "user should get index with his posts" do
    @user = users(:user)
    sign_in @user
    get posts_url
    assert_response :success
    assert_equal @user.posts.length, @controller.instance_variable_get("@posts").length
  end

  test "admin should get new" do
    sign_in admin_users(:admin)
    get new_post_url
    assert_response :success
  end

  test "user should get new" do
    sign_in users(:user)
    get new_post_url
    assert_response :success
  end

  test "admin should create post" do
    @post = posts(:submitted)
    sign_in admin_users(:admin)
    assert_difference("Post.count") do
      post posts_url, params: post_params(@post)
    end
    assert_redirected_to post_url(Post.last)
  end

  test "user should create post" do
    @post = posts(:submitted)
    sign_in users(:user)
    assert_difference("Post.count") do
      post posts_url, params: post_params(@post)
    end
    assert_redirected_to post_url(Post.last)
  end

  test "user should not create post with changed status" do
    @post = posts(:submitted)
    @post.status = "approved"
    sign_in users(:user)
    assert_difference("Post.count") do
      post posts_url, params: post_params(@post)
    end
    assert @post.reload.submitted?
  end

  test "should not create post with invalid params" do
    sign_in users(:user)
    assert_no_difference("Post.count") do
      post posts_url, params: post_params(Post.new)
    end
    assert_equal posts_path, path
  end

  test "admin should show post" do
    sign_in admin_users(:admin)
    get post_url(posts(:submitted))
    assert_response :success
  end

  test "user should show his post" do
    sign_in users(:user)
    get post_url(posts(:submitted))
    assert_response :success
  end

  test "user should not show other user's post" do
    sign_in users(:user)
    assert_raises(Pundit::NotAuthorizedError) do
      get post_url(posts(:submitted_by_abdullah))
    end
  end

  test "admin should get edit" do
    sign_in admin_users(:admin)
    get edit_post_url(posts(:submitted))
    assert_response :success
  end

  test "user should edit his post" do
    sign_in users(:user)
    get edit_post_url(posts(:submitted))
    assert_response :success
  end

  test "user should not edit other user's post" do
    sign_in users(:user)
    assert_raises(Pundit::NotAuthorizedError) do
      get edit_post_url(posts(:submitted_by_abdullah))
    end
  end

  test "user should not edit an approved post" do
    sign_in users(:user)
    assert_raises(Pundit::NotAuthorizedError) do
      get edit_post_url(posts(:approved))
    end
  end

  test "should not update post with invalid params" do
    @post = posts(:submitted)
    sign_in users(:user)
    patch post_url(@post), params: post_params(Post.new)
    assert_equal post_path(@post), path
  end

  test "admin should update post" do
    @post = posts(:submitted)
    sign_in admin_users(:admin)
    patch post_url(@post), params: post_params(@post)
    assert_redirected_to post_url(@post)
  end

  test "user should update his post" do
    @post = posts(:submitted)
    sign_in users(:user)
    patch post_url(@post), params: post_params(@post)
    assert_redirected_to post_url(@post)
  end

  test "user should not update other user's post" do
    @post = posts(:submitted_by_abdullah)
    sign_in users(:user)
    assert_raises(Pundit::NotAuthorizedError) do
      patch post_url(@post), params: post_params(@post)
    end
  end

  test "user should not update an approved post" do
    @post = posts(:approved)
    sign_in users(:user)
    assert_raises(Pundit::NotAuthorizedError) do
      patch post_url(@post), params: post_params(@post)
    end
  end

  test "user should not update post status" do
    @post = posts(:submitted)
    @post.status = "approved"
    sign_in users(:user)
    patch post_url(@post), params: post_params(@post)
    assert @post.reload.submitted?
  end

  test "admin should destroy post" do
    sign_in admin_users(:admin)
    assert_difference("Post.count", -1) do
      delete post_url(posts(:submitted))
    end
    assert_redirected_to posts_url
  end

  test "user should destroy his post" do
    sign_in users(:user)
    assert_difference("Post.count", -1) do
      delete post_url(posts(:submitted))
    end
    assert_redirected_to posts_url
  end

  test "user should not destroy other user's post" do
    sign_in users(:user)
    assert_raises(Pundit::NotAuthorizedError) do
      delete post_url(posts(:submitted_by_abdullah))
    end
  end

  test "user should not destroy an approved post" do
    sign_in users(:user)
    assert_raises(Pundit::NotAuthorizedError) do
      delete post_url(posts(:approved))
    end
  end
end
