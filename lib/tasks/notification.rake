# frozen_string_literal: true

namespace :notification do
  desc "Sends SMS notification to employees asking them to log if they had overtime or not"
  task sms: :environment do
    return if Rails.env.production?

    if Time.now.sunday?
      EmployeeUser.all.each do |employee|
        sms = SmsService.send_sms(
          "Please log into the overtime management dashboard to request overtime or confirm your hours for last week: http://localhost:3000",
          to: employee.phone
        )

        if sms
          puts "Message: #{sms.body}"
          puts "To: #{sms.to} (#{employee.full_name})"
          puts
        end
      end
    end
  end

  desc "Sends mail notification to managers (admin users) each day to inform of pending overtime requests"
  task manager_email: :environment do
    if Post.submitted.count > 0
      AdminUser.all.each { |admin| ManagerMailer.email(admin).deliver_now }
    end
  end
end
