class PaypalService

  def initialize(car)
    @car = Car.friendly.find(car)
    client_id = 'AfLOwpfasi3e8fgpbsH2piZILP5t4-cV_1baCz6-g7Si97exDwPxVLofLQsNnAbVMeEpZmEqLmwLvwgS'
    client_secret = 'EMNBt5aJF-eURZOg6ZKGwNEqk7fDc9njHfTgfxW7nP_SNJYihIOetSPtH0KqJuVHj9d1kN_SumTUqKp5'
    environment = PayPal::SandboxEnvironment.new client_id, client_secret
    @client = PayPal::PayPalHttpClient.new environment
  end

  def create_car
    price = @car.sell_price
    request = PayPalCheckoutSdk::Orders::OrdersCreateRequest::new
    request.request_body({
      :intent => 'CAPTURE',
      :purchase_units => [
        {
          :amount => {
            :currency_code => 'USD',
            :value => price
          }
        }
      ]
    })
    begin
      response = @client.execute request
      return response
    rescue PayPalHttp::HttpError => ioe
      # HANDLE THE ERROR
    end
  end

  def capture_car(order_id)
    request = PayPalCheckoutSdk::Orders::OrdersCaptureRequest::new order_id
    begin
      response = @client.execute request
      return response
    rescue PayPalHttp::HttpError => ioe
      # HANDLE THE ERROR
    end
  end
end
