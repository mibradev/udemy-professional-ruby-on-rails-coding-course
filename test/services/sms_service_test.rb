# frozen_string_literal: true

require "test_helper"

class SmsServiceTest < ActiveSupport::TestCase
  test "should send sms" do
    assert SmsService.send_sms("message", to: "+15005550006")
  end

  test "should not send sms to an invalid number" do
    assert_not SmsService.send_sms("message", to: "+15005550001")
  end
end
