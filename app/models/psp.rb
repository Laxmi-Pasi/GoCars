class Psp < ApplicationRecord
  has_many :car_transactions
  enum  payment_gateway: [:stripe, :paypal, :braintree, :card_connect]
end
