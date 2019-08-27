# frozen_string_literal: true

require "test_helper"

class PostPolicyTest < ActiveSupport::TestCase
  setup do
    @employee1 = employee_users(:ahmad)
    @employee2 = employee_users(:abdullah)
    @admin = admin_users(:admin)
    @post = posts(:submitted)
  end

  test "scope" do
    assert_equal @employee1.posts, Pundit.policy_scope!(@employee1, Post)
    assert_equal @employee2.posts, Pundit.policy_scope!(@employee2, Post)
    assert_equal Post.all, Pundit.policy_scope!(@admin, Post)
  end

  test "permitted attributes" do
    assert_equal [:overtime_request, :date, :rationale], PostPolicy.new(@employee1, @post).permitted_attributes
    assert_equal [:status], PostPolicy.new(@admin, @post).permitted_attributes
  end

  test "index" do
    assert Pundit.policy!(@employee1, Post.all).index?
    assert Pundit.policy!(@employee2, Post.all).index?
    assert Pundit.policy!(@admin, Post.all).index?
  end

  test "show" do
    assert Pundit.policy!(@employee1, @post).show?
    assert_not Pundit.policy!(@employee2, @post).show?
    assert Pundit.policy!(@admin, @post).show?
  end

  test "create" do
    assert Pundit.policy!(@employee1, Post.new).create?
    assert_not Pundit.policy!(@admin, Post.new).create?
  end

  test "update" do
    @approved_post = posts(:approved)
    assert Pundit.policy!(@employee1, @post).update?
    assert_not Pundit.policy!(@employee1, @approved_post).update?
    assert_not Pundit.policy!(@employee2, @post).update?
    assert Pundit.policy!(@admin, @post).update?
    assert Pundit.policy!(@admin, @approved_post).update?
  end

  test "destroy" do
    @approved_post = posts(:approved)
    assert Pundit.policy!(@employee1, @post).destroy?
    assert_not Pundit.policy!(@employee1, @approved_post).destroy?
    assert_not Pundit.policy!(@employee2, @post).destroy?
    assert_not Pundit.policy!(@admin, @post).destroy?
    assert_not Pundit.policy!(@admin, @approved_post).destroy?
  end

  test "change status" do
    assert_not Pundit.policy!(@employee1, @post).change_status?
    assert Pundit.policy!(@admin, @post).change_status?
  end
end
