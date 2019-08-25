# frozen_string_literal: true

# Preview all emails at http://localhost:3000/rails/mailers/manager_mailer
class ManagerMailerPreview < ActionMailer::Preview
  def email
    ManagerMailer.email(AdminUser.first)
  end
end
