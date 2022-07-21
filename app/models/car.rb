class Car < ApplicationRecord
  validates :company, :model, :purchase_date, 
            :car_description, :registered_number, presence: true
  validates :seats, :distance_driven, numericality: { only_integer: true }, presence: true       
  enum engine_type: {
    Petrol: 0,
    Diesel: 1,
    Hybrid: 2,
    EV: 3
  }

  enum car_type: {
    Hatchback: 0,
    Sedan: 1,
    SUV: 2,
    Supercar: 3
  }

  enum transmission_type: {
    Manual: 0,
    Automatic: 1,
  }
  
  #validations pending

end
