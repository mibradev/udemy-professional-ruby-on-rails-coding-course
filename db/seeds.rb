# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

employees = [
  EmployeeUser.create!(
    email: "employee1@example.com",
    password: Rails.application.credentials[Rails.env.to_sym][:user_password],
    first_name: "First",
    last_name: "Employee",
    phone: "5005550006"
  ),
  EmployeeUser.create!(
    email: "employee2@example.com",
    password: Rails.application.credentials[Rails.env.to_sym][:user_password],
    first_name: "Second",
    last_name: "Employee",
    phone: "5005550006"
  )
]

AdminUser.create!(
  email: "admin@example.com",
  password: Rails.application.credentials[Rails.env.to_sym][:user_password],
  first_name: "First",
  last_name: "Admin",
  phone: "5005550006"
)

20.days.ago.to_date.step(6.days.ago.to_date, 7) do |start_date|
  employees[0].audit_logs.create!(start_date: start_date)
  employees[1].audit_logs.create!(start_date: start_date)

  employees.each do |employee|
    employee.posts.create!(
      overtime_request: rand(0.1..20.0),
      date: start_date.ago(1.day),
      rationale: "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
    )
  end
end
