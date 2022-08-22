class CarTransaction < ApplicationRecord
  belongs_to :psp
  belongs_to :car
  belongs_to :owner, class_name: "User"
  belongs_to :buyer, class_name: "User"

  enum  status: [:completed, :processing]

  def payment_gateway?
    owner.payment_gateway
  end
end
