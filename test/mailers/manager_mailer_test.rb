# frozen_string_literal: true

require "test_helper"

class ManagerMailerTest < ActionMailer::TestCase
  test "email" do
    @admin = admin_users(:admin)
    email = ManagerMailer.email(@admin)

    assert_emails 1 do
      email.deliver_now
    end

    assert_equal ["from@example.com"], email.from
    assert_equal [@admin.email], email.to
    assert_equal "Daily Overtime Request Email", email.subject
    assert_equal read_fixture("email").join, email.body.to_s.chomp
  end
end
