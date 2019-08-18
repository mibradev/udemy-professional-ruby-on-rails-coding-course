# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

users = [
  User.create!(email: 'user1@example.com', password: ENV.fetch('RAILS_USER_PASSWORD'), first_name: 'First', last_name: 'User'),
  User.create!(email: 'user2@example.com', password: ENV.fetch('RAILS_USER_PASSWORD'), first_name: 'Second', last_name: 'User'),
  AdminUser.create!(email: 'admin@example.com', password: ENV.fetch('RAILS_USER_PASSWORD'), first_name: 'First', last_name: 'Admin')
]

(1..100).each do |i|
  users.sample.posts.create!(date: Date.current, rationale: "Post #{i} rationale.", status: Post.statuses.keys.sample)
end
