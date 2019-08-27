# frozen_string_literal: true

require "test_helper"

class PostPolicyTest < ActiveSupport::TestCase
  setup do
    @user = users(:user)
    @employee1 = employee_users(:ahmad)
    @employee2 = employee_users(:abdullah)
    @admin = admin_users(:admin)
  end

  test "scope" do
    assert_equal @user.posts, Pundit.policy_scope!(@user, Post)
    assert_equal @employee1.posts, Pundit.policy_scope!(@employee1, Post)
    assert_equal Post.all, Pundit.policy_scope!(@admin, Post)
  end

  test "permitted attributes" do
    assert_equal [], PostPolicy.new(@user, nil).permitted_attributes
    assert_equal [:overtime_request, :date, :rationale], PostPolicy.new(@employee1, nil).permitted_attributes
    assert_equal [:status], PostPolicy.new(@admin, nil).permitted_attributes
  end

  test "index" do
    assert_not Pundit.policy!(@user, Post).index?
    assert Pundit.policy!(@employee1, Post).index?
    assert Pundit.policy!(@admin, Post).index?
  end

  test "show" do
    @post = @employee1.posts.new

    assert_not Pundit.policy!(@user, @user.posts.new).show?

    assert Pundit.policy!(@employee1, @post).show?
    assert_not Pundit.policy!(@employee2, @post).show?
    assert Pundit.policy!(@admin, @post).show?
  end

  test "create" do
    assert_not Pundit.policy!(@user, Post).create?
    assert Pundit.policy!(@employee1, Post).create?
    assert_not Pundit.policy!(@admin, Post).create?
  end

  test "update" do
    @post = @employee1.posts.new
    @approved_post = @employee1.posts.new(status: "approved")

    assert_not Pundit.policy!(@user, @user.posts.new).update?

    assert Pundit.policy!(@employee1, @post).update?
    assert_not Pundit.policy!(@employee2, @post).update?
    assert Pundit.policy!(@admin, @post).update?

    assert_not Pundit.policy!(@employee1, @approved_post).update?
    assert Pundit.policy!(@admin, @approved_post).update?
  end

  test "destroy" do
    @post = @employee1.posts.new
    @approved_post = @employee1.posts.new(status: "approved")

    assert_not Pundit.policy!(@user, @user.posts.new).destroy?

    assert Pundit.policy!(@employee1, @post).destroy?
    assert_not Pundit.policy!(@employee2, @post).destroy?
    assert_not Pundit.policy!(@admin, @post).destroy?

    assert_not Pundit.policy!(@employee1, @approved_post).destroy?
    assert_not Pundit.policy!(@admin, @approved_post).destroy?
  end

  test "change status" do
    @post = @employee1.posts.new

    assert_not Pundit.policy!(@user, @user.posts.new).change_status?

    assert_not Pundit.policy!(@employee1, @post).change_status?
    assert Pundit.policy!(@admin, @post).change_status?
  end
end
