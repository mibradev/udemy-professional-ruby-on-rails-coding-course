# frozen_string_literal: true

namespace :notification do
  desc "Sends mail notification to managers (admin users) each day to inform of pending overtime requests"
  task manager_email: :environment do
    if Post.submitted.count > 0
      AdminUser.all.each { |admin| ManagerMailer.email(admin).deliver_now }
    end
  end
end
