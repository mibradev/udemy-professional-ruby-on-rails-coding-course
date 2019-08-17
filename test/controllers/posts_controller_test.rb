require 'test_helper'

class PostsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  test "admin should get index" do
    sign_in admin_users(:admin)
    get posts_url
    assert_response :success
  end

  test "user should get index with his posts" do
    @user1 = users(:user)
    sign_in @user1
    get posts_url
    assert_response :success
    assert_equal @user1.posts.length, @controller.instance_variable_get("@posts").length
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
    @post1 = posts(:submitted)
    sign_in admin_users(:admin)
    assert_difference('Post.count') do
      post posts_url, params: { post: { date: @post1.date, rationale: @post1.rationale } }
    end
    assert_redirected_to post_url(Post.last)
  end

  test "user should create post" do
    @post1 = posts(:submitted)
    sign_in users(:user)
    assert_difference('Post.count') do
      post posts_url, params: { post: { date: @post1.date, rationale: @post1.rationale } }
    end
    assert_redirected_to post_url(Post.last)
  end

  test "user should not create post with changed status" do
    @post1 = posts(:submitted)
    sign_in users(:user)
    assert_difference('Post.count') do
      post posts_url, params: { post: { date: @post1.date, rationale: @post1.rationale, status: 'approved' } }
    end
    assert_equal 'submitted', @post1.reload.status
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

  test "admin should update post" do
    @post1 = posts(:submitted)
    sign_in admin_users(:admin)
    patch post_url(@post1), params: { post: { date: @post1.date, rationale: @post1.rationale } }
    assert_redirected_to post_url(@post1)
  end

  test "user should update his post" do
    @post1 = posts(:submitted)
    sign_in users(:user)
    patch post_url(@post1), params: { post: { date: @post1.date, rationale: @post1.rationale } }
    assert_redirected_to post_url(@post1)
  end

  test "user should not update other user's post" do
    @post2 = posts(:submitted_by_abdullah)
    sign_in users(:user)
    assert_raises(Pundit::NotAuthorizedError) do
      patch post_url(@post2), params: { post: { date: @post2.date, rationale: @post2.rationale } }
    end
  end

  test "user should not update post status" do
    @post1 = posts(:submitted)
    sign_in users(:user)
    patch post_url(@post1), params: { post: { date: @post1.date, rationale: @post1.rationale, status: 'approved' } }
    assert_equal 'submitted', @post1.reload.status
  end

  test "admin should destroy post" do
    sign_in admin_users(:admin)
    assert_difference('Post.count', -1) do
      delete post_url(posts(:submitted))
    end
    assert_redirected_to posts_url
  end

  test "user should destroy his post" do
    sign_in users(:user)
    assert_difference('Post.count', -1) do
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
end
