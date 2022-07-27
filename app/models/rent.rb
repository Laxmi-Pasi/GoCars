class Rent < ApplicationRecord
  belongs_to :user
  belongs_to :car
  
  def owner
    car.owner
  end
end
