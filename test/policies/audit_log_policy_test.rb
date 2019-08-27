# frozen_string_literal: true

require "test_helper"

class AuditLogPolicyTest < ActiveSupport::TestCase
  setup do
    @user = users(:user)
    @employee1 = employee_users(:ahmad)
    @employee2 = employee_users(:abdullah)
    @admin = admin_users(:admin)
  end

  test "scope" do
    assert_equal AuditLog.all, Pundit.policy_scope!(@employee1, AuditLog)
    assert_equal AuditLog.all, Pundit.policy_scope!(@admin, AuditLog)
  end

  test "index" do
    assert_not Pundit.policy!(@user, AuditLog).index?
    assert_not Pundit.policy!(@employee1, AuditLog).index?
    assert Pundit.policy!(@admin, AuditLog).index?
  end

  test "show" do
    @audit_log = @employee1.audit_logs.new

    assert_not Pundit.policy!(@user, @user.audit_logs.new).show?

    assert Pundit.policy!(@employee1, @audit_log).show?
    assert_not Pundit.policy!(@employee2, @audit_log).show?
    assert Pundit.policy!(@admin, @audit_log).show?
  end

  test "create" do
    assert_not Pundit.policy!(@user, AuditLog).create?
    assert_not Pundit.policy!(@employee1, AuditLog).create?
    assert_not Pundit.policy!(@admin, AuditLog).create?
  end

  test "update" do
    @pending_audit_log = @employee1.audit_logs.pending.new
    @confirmed_audit_log = @employee1.audit_logs.confirmed.new

    assert_not Pundit.policy!(@user, @user.audit_logs.pending.new).update?

    assert Pundit.policy!(@employee1, @pending_audit_log).update?
    assert_not Pundit.policy!(@employee2, @pending_audit_log).update?
    assert_not Pundit.policy!(@admin, @pending_audit_log).update?

    assert_not Pundit.policy!(@employee1, @confirmed_audit_log).update?
    assert_not Pundit.policy!(@admin, @confirmed_audit_log).update?
  end

  test "destroy" do
    assert_not Pundit.policy!(@user, AuditLog).destroy?
    assert_not Pundit.policy!(@employee1, AuditLog).destroy?
    assert_not Pundit.policy!(@admin, AuditLog).destroy?
  end
end
