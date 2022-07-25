class Car < ApplicationRecord
  validates :company, :model, :purchase_date, 
            :car_description, :registered_number, presence: true
  validates :seats, :distance_driven, numericality: { only_integer: true }, presence: true       
  enum engine_type: [:Petrol, :Diesel, :Hybrid, :EV ]
  enum car_type: [:Hatchback, :Sedan, :SUV, :Supercar]
  enum transmission_type: [:Manual, :Automatic]
end
