class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable      
  has_many :rents
  has_many :cars, through: :rents
  has_many :vehicles, foreign_key: "owner_id", class_name: "Car"
  validates :first_name,:last_name, presence: true, length: {minimum:3 , maximum:25}
  VALID_EMAIL_REGEX= /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  PASSWORD_FORMAT = /\A
    (?=.{8,})          # Must contain 8 or more characters 
    (?=.*\d)           # Must contain a digit
    (?=.*[a-z])        # Must contain a lower case character
    (?=.*[A-Z])        # Must contain an upper case character
    (?=.*[[:^alnum:]]) # Must contain a symbol
  /x
  validates :password, 
    presence: true, 
    length: { in: Devise.password_length }, 
    format: { with: PASSWORD_FORMAT }, 
    confirmation: true, 
    on: :create 
  validates :password, 
    allow_nil: true, 
    length: { in: Devise.password_length }, 
    format: { with: PASSWORD_FORMAT }, 
    confirmation: true, 
    on: :update
  validates :email, presence: true,uniqueness: {case_sensitive: false}, length: {maximum:105}, format: { with: VALID_EMAIL_REGEX}
  validates :contact,numericality: {only_integer: true, message: "must be number"},
            length: {is: 10, message: "must be of ten digits"},uniqueness: true
end
