# frozen_string_literal: true

require "test_helper"

class AuditLogsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    sign_in admin_users(:admin)
  end

  test "admin should get index" do
    get audit_logs_url
    assert_response :success
  end

  test "admin should get new" do
    get new_audit_log_url
    assert_response :success
  end

  test "admin should create audit log" do
    assert_difference("AuditLog.count") do
      post audit_logs_url, params: audit_log_params(audit_logs(:pending))
    end
    assert_redirected_to audit_log_url(AuditLog.last)
  end

  test "admin should not create invalid audit log" do
    assert_no_difference("AuditLog.count") do
      post audit_logs_url, params: audit_log_params(AuditLog.new(status: nil))
    end
    assert_equal audit_logs_path, path
  end

  test "admin should show audit log" do
    get audit_log_url(audit_logs(:pending))
    assert_response :success
  end

  test "admin should get edit" do
    get edit_audit_log_url(audit_logs(:pending))
    assert_response :success
  end

  test "admin should update audit log" do
    @audit_log = audit_logs(:pending)
    patch audit_log_url(@audit_log), params: audit_log_params(@audit_log)
    assert_redirected_to audit_log_url(@audit_log)
  end

  test "admin should not update invalid audit log" do
    @audit_log = audit_logs(:pending)
    patch audit_log_url(@audit_log), params: audit_log_params(AuditLog.new(status: nil))
    assert_equal audit_log_path(@audit_log), path
  end

  test "admin should destroy audit log" do
    assert_difference("AuditLog.count", -1) do
      delete audit_log_url(audit_logs(:pending))
    end
    assert_redirected_to audit_logs_url
  end

  test "user should not have access" do
    @audit_log = audit_logs(:pending)

    assert_raises(Pundit::NotAuthorizedError) do
      sign_in users(:user)
      get audit_logs_url
    end

    assert_raises(Pundit::NotAuthorizedError) do
      sign_in users(:user)
      get audit_log_url(@audit_log)
    end

    assert_raises(Pundit::NotAuthorizedError) do
      sign_in users(:user)
      get new_audit_log_url
    end

    assert_raises(Pundit::NotAuthorizedError) do
      sign_in users(:user)
      get edit_audit_log_url(@audit_log)
    end

    assert_raises(Pundit::NotAuthorizedError) do
      sign_in users(:user)
      post audit_logs_url
    end

    assert_raises(Pundit::NotAuthorizedError) do
      sign_in users(:user)
      patch audit_log_url(@audit_log)
    end

    assert_raises(Pundit::NotAuthorizedError) do
      sign_in users(:user)
      delete audit_log_url(@audit_log)
    end
  end

  private
    def audit_log_params(audit_log)
      { audit_log: { end_date: audit_log.end_date, start_date: audit_log.start_date, status: audit_log.status } }
    end
end
