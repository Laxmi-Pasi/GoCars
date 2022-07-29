# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

5.times do |i|
  User.create(first_name: "User ##{i}", last_name: "User ##{i}", email:"user#{i}@user.user", password: "123456", password_confirmation: "123456")
end

5.times do |i|
  Car.create(coma)
end
