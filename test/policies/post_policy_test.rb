require 'test_helper'

class PostPolicyTest < ActiveSupport::TestCase
  setup do
    @user1 = users(:user)
    @user2 = users(:abdullah)
    @admin = admin_users(:admin)
    @post = posts(:submitted)
  end

  test "scope" do
    assert_equal @user1.posts, Pundit.policy_scope!(@user1, Post)
    assert_equal @user2.posts, Pundit.policy_scope!(@user2, Post)
    assert_equal Post.all, Pundit.policy_scope!(@admin, Post)
  end

  test "permitted attributes" do
    params = [:overtime_request, :date, :rationale]
    assert_equal params, PostPolicy.new(@user1, @post).permitted_attributes
    assert_equal params.push(:status), PostPolicy.new(@admin, @post).permitted_attributes
  end

  test "index" do
    assert Pundit.policy!(@user1, Post.all).index?
    assert Pundit.policy!(@user2, Post.all).index?
    assert Pundit.policy!(@admin, Post.all).index?
  end

  test "show" do
    assert Pundit.policy!(@user1, @post).show?
    assert_not Pundit.policy!(@user2, @post).show?
    assert Pundit.policy!(@admin, @post).show?
  end

  test "create" do
    assert Pundit.policy!(@user1, Post.new).create?
    assert Pundit.policy!(@admin, Post.new).create?
  end

  test "update" do
    @approved_post = posts(:approved)
    assert Pundit.policy!(@user1, @post).update?
    assert_not Pundit.policy!(@user1, @approved_post).update?
    assert_not Pundit.policy!(@user2, @post).update?
    assert Pundit.policy!(@admin, @post).update?
    assert Pundit.policy!(@admin, @approved_post).update?
  end

  test "destroy" do
    @approved_post = posts(:approved)
    assert Pundit.policy!(@user1, @post).destroy?
    assert_not Pundit.policy!(@user1, @approved_post).destroy?
    assert_not Pundit.policy!(@user2, @post).destroy?
    assert Pundit.policy!(@admin, @post).destroy?
    assert Pundit.policy!(@admin, @approved_post).destroy?
  end

  test "change status" do
    assert_not Pundit.policy!(@user1, @post).change_status?
    assert Pundit.policy!(@admin, @post).change_status?
  end
end
