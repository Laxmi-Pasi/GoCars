class StripePsp < Psp
  def sell_car(car)
    puts "--strip----"
    binding.pry
    @car = Car.friendly.find(car)
    price = @car.sell_price.to_i
    Stripe.api_key = @car.owner.Secret_key
    session = Stripe::Checkout::Session.create({
      payment_method_types: ["card"],
      line_items: [{
        name: "car.name",
        amount: price,
        currency: "usd",
        quantity: 1,
        }],
        mode: "payment",
        success_url: "http://localhost:3000/",
        cancel_url: "http://localhost:3000/",
        })
  end
  def payment_response
    
  end
end
  