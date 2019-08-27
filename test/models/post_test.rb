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

  test "should confirm audit log after submit" do
    @audit_log = @post.audit_logs.pending.started_before(@post).last
    @post.save
    assert @audit_log.reload.confirmed?
  end

  test "should unconfirm audit log after reject" do
    @audit_log = @post.audit_logs.confirmed.started_before(@post).last
    @post.rejected!
    assert @audit_log.reload.pending?
  end
end
