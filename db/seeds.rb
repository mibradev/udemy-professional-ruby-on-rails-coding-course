# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user = User.create!(email: 'user@example.com', password: ENV.fetch('RAILS_USER_PASSWORD'), first_name: 'First', last_name: 'User')
admin = AdminUser.create!(email: 'admin@example.com', password: ENV.fetch('RAILS_USER_PASSWORD'), first_name: 'First', last_name: 'Admin')

100.times do |i|
  user.posts.create!(date: Date.current, rationale: "Post #{i + 1} rationale.")
end
