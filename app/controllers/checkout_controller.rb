class CheckoutController < ApplicationController
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  def sell
    @car = Car.friendly.find(params[:id])
    price = @car.sell_price.to_i
    Stripe.api_key = @car.owner.Secret_key
    @public_key = @car.owner.Public_key
    @session = Stripe::Checkout::Session.create({
      payment_method_types: ["card"],
      line_items: [{
        name: "car.name",
        amount: price,
        currency: "inr",
        quantity: 1,
        }],
        mode: "payment",
        success_url: root_url,
        cancel_url: root_url,
        })
        respond_to do |format|
      format.js
    end
  end  
  def rent
    @car = Car.friendly.find(params[:id])
    price = @car.rent_price.to_i
    Stripe.api_key = @car.owner.Secret_key
    @public_key = @car.owner.Public_key
    @session = Stripe::Checkout::Session.create({
      payment_method_types: ["card"],
      line_items: [{
        name: "car.name",
        amount: price,
        currency: "inr",
        quantity: 1,
        }],
        mode: "payment",
        success_url: root_url,
        cancel_url: root_url,
        })
        respond_to do |format|
      format.js
    end
    # redirect_to @session.url, allow_other_host: true
  end
end
