# frozen_string_literal: true

require "test_helper"

class PostTest < ActiveSupport::TestCase
  def setup
    @post = posts(:submitted)
  end

  test "should be valid" do
    assert @post.valid?
  end

  test "should have user" do
    @post.user_id = nil
    assert_not @post.valid?
  end

  test "should have overtime request" do
    @post.overtime_request = nil
    assert_not @post.valid?
  end

  test "overtime request should be greater than zero" do
    @post.overtime_request = 0.0
    assert_not @post.valid?
  end

  test "overtime request should be less than or equal to 20" do
    @post.overtime_request = 20.1
    assert_not @post.valid?
  end

  test "should have date" do
    @post.date = nil
    assert_not @post.valid?
  end

  test "should have rationale" do
    @post.rationale = nil
    assert_not @post.valid?
  end

  test "should be submitted" do
    assert @post.submitted?
  end

  test "should be approved" do
    assert posts(:approved).approved?
  end

  test "should be rejected" do
    assert posts(:rejected).rejected?
  end

  test "should update audit log after save" do
    @audit_log = @post.audit_logs.pending.where(start_date: (@post.date - 7.days)..@post.date).last
    assert @audit_log.pending?
    @post.save
    assert @audit_log.reload.confirmed?
  end
end
