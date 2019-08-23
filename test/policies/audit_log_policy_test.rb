# frozen_string_literal: true

require "test_helper"

class AuditLogPolicyTest < ActiveSupport::TestCase
  setup do
    @user = users(:user)
    @admin = admin_users(:admin)
    @audit_log = audit_logs(:pending)
  end

  test "scope" do
    assert_equal AuditLog.all, Pundit.policy_scope!(@admin, AuditLog)
  end

  test "index" do
    assert_not Pundit.policy!(@user, AuditLog.all).index?
    assert Pundit.policy!(@admin, AuditLog.all).index?
  end

  test "show" do
    assert_not Pundit.policy!(@user, @audit_log).show?
    assert Pundit.policy!(@admin, @audit_log).show?
  end

  test "create" do
    assert_not Pundit.policy!(@user, AuditLog.new).create?
    assert Pundit.policy!(@admin, AuditLog.new).create?
  end

  test "update" do
    assert_not Pundit.policy!(@user, @audit_log).update?
    assert Pundit.policy!(@admin, @audit_log).update?
  end

  test "destroy" do
    assert_not Pundit.policy!(@user, @audit_log).destroy?
    assert Pundit.policy!(@admin, @audit_log).destroy?
  end
end
