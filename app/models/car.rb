class Car < ApplicationRecord
  has_many :rents
  has_many :users, through: :rents
  belongs_to :owner, class_name: "User"
  has_one_attached :main_car_image
  has_many_attached :car_images
  
  validates :company, :model, :purchase_date, 
            :car_description, :registered_number, presence: true
  validates :seats, :distance_driven, numericality: { only_integer: true }, presence: true       
  enum engine_type: [:Petrol, :Diesel, :Hybrid, :EV ]
  enum car_type: [:Hatchback, :Sedan, :SUV, :Supercar]
  enum transmission_type: [:Manual, :Automatic]
  enum car_status: [:active, :rent, :sold] 

  # to check car images
  def has_car_images?
    car_images_attachments === [] ? false : true
  end
end
