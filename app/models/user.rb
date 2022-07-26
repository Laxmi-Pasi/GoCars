class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable      
  validates :first_name,:last_name, presence: true, length: {minimum:3 , maximum:25}
  VALID_EMAIL_REGEX= /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  VALID_PASSWORD_REGEX = /(?=.*[a-zA-Z])(?=.*[0-9])(?=.*[\W]).{8,}\z/i
  validates :email, presence: true,uniqueness: {case_sensitive: false}, length: {maximum:105}, format: { with: VALID_EMAIL_REGEX}
  validates :password, format: { with: VALID_PASSWORD_REGEX }, if: :skip_validation
  validates :contact,:presence => true,
            :numericality => true,
            :length => { :minimum => 10, :maximum => 15 }
  before_update: :skip_validation
  def skip_validation
    if self.password == nil
      return false
    else
      return true
    end
  end
end
