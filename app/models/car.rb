class Car < ApplicationRecord
  
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
  
end
