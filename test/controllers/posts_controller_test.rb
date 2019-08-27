# frozen_string_literal: true

require "test_helper"

class PostsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  test "admin should get index" do
    sign_in admin_users(:admin)
    get posts_url
    assert_response :success
  end

  test "employee should get index with his posts" do
    @employee = employee_users(:ahmad)
    sign_in @employee
    get posts_url
    assert_response :success
    assert_equal @employee.posts.length, @controller.instance_variable_get("@posts").length
  end

  test "admin should not get new" do
    sign_in admin_users(:admin)
    assert_raises(Pundit::NotAuthorizedError) do
      get new_post_url
    end
  end

  test "employee should get new" do
    sign_in employee_users(:ahmad)
    get new_post_url
    assert_response :success
  end

  test "admin should not create post" do
    @post = posts(:submitted)
    sign_in admin_users(:admin)
    assert_raises(Pundit::NotAuthorizedError) do
      post posts_url, params: post_params(@post)
    end
  end

  test "employee should create post" do
    @post = posts(:submitted)
    sign_in employee_users(:ahmad)
    assert_difference("Post.count") do
      post posts_url, params: post_params(@post)
    end
    assert_redirected_to post_url(Post.last)
  end

  test "employee should not create post with changed status" do
    @post = posts(:submitted)
    @post.status = "approved"
    sign_in employee_users(:ahmad)
    assert_difference("Post.count") do
      post posts_url, params: post_params(@post)
    end
    assert @post.reload.submitted?
  end

  test "should not create post with invalid params" do
    sign_in employee_users(:ahmad)
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

  test "employee should show his post" do
    sign_in employee_users(:ahmad)
    get post_url(posts(:submitted))
    assert_response :success
  end

  test "employee should not show other employee's post" do
    sign_in employee_users(:ahmad)
    assert_raises(Pundit::NotAuthorizedError) do
      get post_url(posts(:submitted_by_abdullah))
    end
  end

  test "admin should get edit" do
    sign_in admin_users(:admin)
    get edit_post_url(posts(:submitted))
    assert_response :success
  end

  test "employee should edit his post" do
    sign_in employee_users(:ahmad)
    get edit_post_url(posts(:submitted))
    assert_response :success
  end

  test "employee should not edit other employee's post" do
    sign_in employee_users(:ahmad)
    assert_raises(Pundit::NotAuthorizedError) do
      get edit_post_url(posts(:submitted_by_abdullah))
    end
  end

  test "employee should not edit an approved post" do
    sign_in employee_users(:ahmad)
    assert_raises(Pundit::NotAuthorizedError) do
      get edit_post_url(posts(:approved))
    end
  end

  test "should not update post with invalid params" do
    @post = posts(:submitted)
    sign_in employee_users(:ahmad)
    patch post_url(@post), params: post_params(Post.new)
    assert_equal post_path(@post), path
  end

  test "admin should update post" do
    @post = posts(:submitted)
    @post.status = "approved"
    sign_in admin_users(:admin)
    patch post_url(@post), params: post_params(@post)
    assert_redirected_to post_url(@post)
    assert @post.reload.approved?
  end

  test "admin should update post status only" do
    @post1 = posts(:submitted)
    @post2 = posts(:submitted_by_abdullah)
    sign_in admin_users(:admin)
    patch post_url(@post1), params: post_params(@post2)
    assert_equal @post1.attributes.except("status"), @post1.reload.attributes.except("status")
  end

  test "employee should update his post" do
    @post = posts(:submitted)
    sign_in employee_users(:ahmad)
    patch post_url(@post), params: post_params(@post)
    assert_redirected_to post_url(@post)
  end

  test "employee should not update other employee's post" do
    @post = posts(:submitted_by_abdullah)
    sign_in employee_users(:ahmad)
    assert_raises(Pundit::NotAuthorizedError) do
      patch post_url(@post), params: post_params(@post)
    end
  end

  test "employee should not update an approved post" do
    @post = posts(:approved)
    sign_in employee_users(:ahmad)
    assert_raises(Pundit::NotAuthorizedError) do
      patch post_url(@post), params: post_params(@post)
    end
  end

  test "employee should not update post status" do
    @post = posts(:submitted)
    @post.status = "approved"
    sign_in employee_users(:ahmad)
    patch post_url(@post), params: post_params(@post)
    assert @post.reload.submitted?
  end

  test "admin should not destroy post" do
    sign_in admin_users(:admin)
    assert_raises(Pundit::NotAuthorizedError) do
      delete post_url(posts(:submitted))
    end
  end

  test "employee should destroy his post" do
    sign_in employee_users(:ahmad)
    assert_difference("Post.count", -1) do
      delete post_url(posts(:submitted))
    end
    assert_redirected_to posts_url
  end

  test "employee should not destroy other employee's post" do
    sign_in employee_users(:ahmad)
    assert_raises(Pundit::NotAuthorizedError) do
      delete post_url(posts(:submitted_by_abdullah))
    end
  end

  test "employee should not destroy an approved post" do
    sign_in employee_users(:ahmad)
    assert_raises(Pundit::NotAuthorizedError) do
      delete post_url(posts(:approved))
    end
  end

  private
    def post_params(post)
      { post: { overtime_request: post.overtime_request, date: post.date, rationale: post.rationale, status: post.status } }
    end
end
