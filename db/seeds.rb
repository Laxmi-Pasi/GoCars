# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require 'time'

5.times do |i|
  # ------------  User Create ------------
  user = User.create!(first_name: "User#{i}", last_name: "User#{i}", contact: 7856421320 + i, email: "user#{i}@user.user", password: "User@123456", password_confirmation: "User@123456")


  # ------------  Car Create ------------  
  car = Car.create!( company: "company #{i}", model: "model #{i}", purchase_date: "5-10-2000", engine_type: 0, car_type: 0, seats: 5, distance_driven: 2000 + i, transmission_type: 0, car_description: "This is #{i}th car", registered_number: "GJ03AB000#{i}", owner_id: user.id, purpose: "[sell,rent]", sell_price: 250000, rent_price: 15 )


  # ------------  Rent Create ------------
  Rent.create!(user_id: user.id, car_id: car.id, no_of_days: 5, Total_Price: 75)


  # --------------  Confirm User-Account ------------
  user.update(confirmed_at: Time.now())
end
