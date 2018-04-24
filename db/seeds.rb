# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.destroy_all
Book.destroy_all
Member.destroy_all

User.create(username: "admin", email: "admin@imug.com", password: "12345678", admin: true)
Member.create(email: "admin@gmail.com", password: "12345678", admin: true)
10.times do
  username = Faker::Internet.unique.user_name(5..10)
  email = Faker::Internet.unique.email
  password = "12345678"
  User.create!(username: username, email: email, password: password)
  Member.create!(email: email, password: password)
end

30.times do
  title = Faker::Book.title
  author = Faker::Book.author
  #ids = User.where(admin: false).pluck(:id).shuffle[0]
  ids = User.pluck(:id).shuffle[0]
  Book.create(title: title, author: author, member_id: ids)
end
