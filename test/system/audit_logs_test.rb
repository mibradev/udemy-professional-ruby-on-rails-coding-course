# frozen_string_literal: true

require "application_system_test_case"

class AuditLogsTest < ApplicationSystemTestCase
  setup do
    @audit_log = audit_logs(:pending)
    @employee = employee_users(:ahmad)
    @admin = admin_users(:admin)
  end

  test "admin visiting the index" do
    sign_in @admin
    visit audit_logs_url
    assert_selector "h2", text: "Audit Logs"
  end

  test "admin showing the audit log" do
    sign_in @admin
    visit audit_logs_url
    click_on "Show", match: :first
    assert_selector "h2", text: "Audit Log ##{@audit_log.id}"
  end
end
