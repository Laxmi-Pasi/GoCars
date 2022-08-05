class CheckoutController < ApplicationController
  def create
    @car = Car.find(params[:id])
    Stripe.api_key = @car.owner.
    @public_key = @car.owner.Public_key
    @session = Stripe::Checkout::Session.create({
      payment_method_types: ["card"],
      line_items: [{
        name: "car.name",
        amount: 100,
        currency: "usd",
        quantity: 1,
        }],
        mode: "payment",
        success_url: root_url,
        cancel_url: root_url,
        })
        # binding.pry
        respond_to do |format|
      format.js
    end
    # redirect_to @session.url, allow_other_host: true
  end
end
