class Car < ApplicationRecord
  attr_accessor :sell_checked
  attr_accessor :rent_checked
  attr_accessor :invalid_purpose
  searchkick text_middle: [:company, :model]
  extend FriendlyId
  friendly_id :slug_candidates, use: :slugged
  has_many :rents
  has_many :users, through: :rents, dependent: :destroy
  belongs_to :owner, class_name: "User"
  has_one_attached :main_car_image, dependent: :destroy
  has_many_attached :car_images
  has_many :car_transactions
  validates :company, :model, :purchase_date, 
            :car_description, :registered_number, presence: true
  validates :registered_number, presence: true, uniqueness: true 
  validates :seats, :distance_driven, numericality: { only_integer: true }, presence: true       
  enum engine_type: [:Petrol, :Diesel, :Hybrid, :EV ]
  enum car_type: [:Hatchback, :Sedan, :SUV, :Supercar]
  enum transmission_type: [:Manual, :Automatic]
  enum car_status: [:active, :rent, :sold] 

  # serialize :purpose, Array
  validates :sell_price, presence: true, if: :sell_checked
  validates :rent_price, presence: true, if: :rent_checked
  validates :purpose, presence: { message: "Car should be available for one purpose" }, if: :invalid_purpose
  
  # callback
  after_update :generate_reindex_for_searchkick
  
  # to generate reindex for searchkick
  def generate_reindex_for_searchkick
    reindex
  end

  # to check car images
  def has_car_images?
    car_images_attachments != []
  end

  # to add slug_candidates
  def slug_candidates
    [
      [:company, :registered_number, :car_type]
    ]
  end

  def currently_rent_by
    if car_status == "rent"
      current_renter = rents.last.user
    else
      "Car is Available for Rent"
    end
  end

  def rent_by_all
    all_renters = []
    rents.each do |renter|  # rents is association method cause we have one to many between car - rents
      all_renters.push(renter.user)
    end
    return all_renters
  end

  def payment_gateway?
    owner.payment_gateway
  end
end
