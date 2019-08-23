# frozen_string_literal: true

require "application_system_test_case"

class AuditLogsTest < ApplicationSystemTestCase
  setup do
    @audit_log = audit_logs(:pending)
    sign_in admin_users(:admin)
  end

  test "visiting the index" do
    visit audit_logs_url
    assert_selector "h2", text: "Audit Logs"
  end

  test "creating a audit log" do
    visit root_url
    find("nav").click_link "Audit Logs"
    click_on "New Audit Log"

    fill_in "Week Starting", with: @audit_log.start_date
    fill_in "Confirmed At", with: @audit_log.end_date
    choose "Pending"
    click_on "Create Audit log"

    assert_text "Audit log was successfully created"
  end

  test "updating a audit log" do
    visit audit_logs_url
    click_on "Edit", match: :first

    fill_in "Week Starting", with: @audit_log.start_date
    fill_in "Confirmed At", with: @audit_log.end_date
    choose "Confirmed"
    click_on "Update Audit log"

    assert_text "Audit log was successfully updated"
  end

  test "destroying a audit log" do
    visit audit_logs_url
    page.accept_confirm do
      click_on "Delete", match: :first
    end
    assert_text "Audit log was successfully destroyed"
  end
end
