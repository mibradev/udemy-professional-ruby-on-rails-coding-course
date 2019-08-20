# frozen_string_literal: true

class SmsService
  TWILIO_ACCOUNT_SID = Rails.application.credentials[Rails.env.to_sym][:twilio][:account_sid]
  TWILIO_AUTH_TOKEN = Rails.application.credentials[Rails.env.to_sym][:twilio][:auth_token]
  TWILIO_NUMBER = Rails.application.credentials[Rails.env.to_sym][:twilio][:number]

  class << self
    @@client = Twilio::REST::Client.new(TWILIO_ACCOUNT_SID, TWILIO_AUTH_TOKEN)

    def send_sms(message, to:)
      @@client.messages.create from: TWILIO_NUMBER, to: to, body: message
    rescue Twilio::REST::RestError => error
      Rails.logger.error error.full_message
      false
    end
  end
end
