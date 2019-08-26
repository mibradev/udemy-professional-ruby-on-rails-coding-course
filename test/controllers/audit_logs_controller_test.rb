# frozen_string_literal: true

require "test_helper"

class AuditLogsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @employee1 = employee_users(:ahmad)
    @employee2 = employee_users(:abdullah)
    @admin = admin_users(:admin)
  end

  test "should not get new" do
    sign_in @admin
    assert_raises(Pundit::NotAuthorizedError) do
      get new_audit_log_url
    end
  end

  test "should not create audit log" do
    sign_in @admin
    assert_raises(Pundit::NotAuthorizedError) do
      post audit_logs_url, params: audit_log_params(audit_logs(:pending))
    end
  end

  test "should not create invalid audit log" do
    sign_in @admin
    assert_raises(Pundit::NotAuthorizedError) do
      post audit_logs_url, params: audit_log_params(AuditLog.new(status: nil))
    end
  end

  test "should not get edit" do
    sign_in @admin
    assert_raises(Pundit::NotAuthorizedError) do
      get edit_audit_log_url(audit_logs(:pending))
    end
  end

  test "should not update invalid audit log" do
    sign_in @admin
    @audit_log = audit_logs(:pending)
    assert_raises(Pundit::NotAuthorizedError) do
      patch audit_log_url(@audit_log), params: audit_log_params(AuditLog.new(status: nil))
    end
  end

  test "should not update audit log" do
    sign_in @admin
    @audit_log = audit_logs(:pending)
    assert_raises(Pundit::NotAuthorizedError) do
      patch audit_log_url(@audit_log), params: audit_log_params(@audit_log)
    end
  end

  test "should not destroy audit log" do
    sign_in @admin
    assert_raises(Pundit::NotAuthorizedError) do
      delete audit_log_url(audit_logs(:pending))
    end
  end

  test "employee should not get index" do
    sign_in @employee1
    assert_raises(Pundit::NotAuthorizedError) do
      get audit_logs_url
    end
  end

  test "employee should not show other user's audit log" do
    sign_in @employee2
    assert_raises(Pundit::NotAuthorizedError) do
      get audit_log_url(@employee1.audit_logs.first)
    end
  end

  test "employee should update audit log" do
    @audit_log = audit_logs(:pending)
    sign_in @employee1
    patch audit_log_url(@audit_log), params: audit_log_params(AuditLog.new(status: "confirmed"))
    assert_redirected_to audit_log_url(@audit_log)
  end

  test "admin should get index" do
    sign_in @admin
    get audit_logs_url
    assert_response :success
  end

  test "admin should show audit_log" do
    sign_in @admin
    get audit_log_url(@employee1.audit_logs.first)
    assert_response :success
  end

  private
    def audit_log_params(audit_log)
      { audit_log: { end_date: audit_log.end_date, start_date: audit_log.start_date, status: audit_log.status } }
    end
end
