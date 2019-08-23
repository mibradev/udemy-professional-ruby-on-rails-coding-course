# frozen_string_literal: true

require "test_helper"

class AuditLogTest < ActiveSupport::TestCase
  setup do
    @audit_log = audit_logs(:pending)
  end

  test "should be valid" do
    assert @audit_log.valid?
  end

  test "should have status" do
    @audit_log.status = nil
    assert_not @audit_log.valid?
    assert_equal ["pending", "confirmed"], AuditLog.statuses.keys
  end

  test "should have start date" do
    @audit_log.start_date = nil
    assert_not @audit_log.valid?
  end

  test "start date should have default value" do
    assert_equal 6.days.ago.to_date, @audit_log.start_date
    assert_equal 6.days.ago.to_date, AuditLog.new.start_date
  end

  test "start date should be changeable" do
    @audit_log.start_date = 1.days.ago.to_date
    assert_equal 1.days.ago.to_date, @audit_log.start_date
    assert_equal 1.days.ago.to_date, AuditLog.new(start_date: 1.days.ago.to_date).start_date
  end

  test "should have user" do
    @audit_log.user_id = nil
    assert_not @audit_log.valid?
  end
end
