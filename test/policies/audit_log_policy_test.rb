# frozen_string_literal: true

require "test_helper"

class AuditLogPolicyTest < ActiveSupport::TestCase
  setup do
    @user1 = users(:user)
    @user2 = users(:abdullah)
    @admin = admin_users(:admin)
  end

  test "scope" do
    assert_equal AuditLog.all, Pundit.policy_scope!(@user1, AuditLog)
    assert_equal AuditLog.all, Pundit.policy_scope!(@admin, AuditLog)
  end

  test "index" do
    assert_not Pundit.policy!(@user1, AuditLog).index?
    assert Pundit.policy!(@admin, AuditLog).index?
  end

  test "show" do
    @audit_log = @user1.audit_logs.first
    assert Pundit.policy!(@user1, @audit_log).show?
    assert_not Pundit.policy!(@user2, @audit_log).show?
    assert Pundit.policy!(@admin, @audit_log).show?
  end

  test "create" do
    assert_not Pundit.policy!(@user1, AuditLog).create?
    assert_not Pundit.policy!(@admin, AuditLog).create?
  end

  test "update" do
    @pending_audit_log = @user1.audit_logs.pending.first
    assert Pundit.policy!(@user1, @pending_audit_log).update?
    assert_not Pundit.policy!(@admin, @pending_audit_log).update?

    @confirmed_audit_log = @user1.audit_logs.confirmed.first
    assert_not Pundit.policy!(@user1, @confirmed_audit_log).update?
    assert_not Pundit.policy!(@admin, @confirmed_audit_log).update?
  end

  test "destroy" do
    assert_not Pundit.policy!(@user1, AuditLog).destroy?
    assert_not Pundit.policy!(@admin, AuditLog).destroy?
  end
end
