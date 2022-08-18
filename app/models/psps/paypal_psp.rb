class PaypalPsp < Psp
  has_many :car_transactions
  
  def sell_car(transaction_id)
    paypal_init
    @car=CarTransaction.find(transaction_id).car
    price = @car.sell_price
    request = PayPalCheckoutSdk::Orders::OrdersCreateRequest::new
    request.request_body({
      :intent => 'CAPTURE',
      :purchase_units => [
        {
          :amount => {
            :currency_code => 'USD',
            :value => price
          },
          custom_id: transaction_id
        }
      ],
    })
    begin
      response = @client.execute request
      return response
    rescue PayPalHttp::HttpError => ioe
      # HANDLE THE ERROR
    end
  end

  def payment_response(car_transaction_id,transaction_token)
    paypal_init
    @transaction = CarTransaction.find(car_transaction_id)
    request = PayPalCheckoutSdk::Orders::OrdersCaptureRequest::new transaction_token
    begin
      response = @client.execute request
      if response.result.status.downcase == "completed"
        @transaction.update!(response_token: transaction_token, status:"completed")
        @transaction.car.update!(buyer_id: @transaction.buyer_id, car_status: "sold")
      end
      return response
    rescue PayPalHttp::HttpError => ioe
      # HANDLE THE ERROR
    end
  end

  # init
  def paypal_init
    client_id = 'AfLOwpfasi3e8fgpbsH2piZILP5t4-cV_1baCz6-g7Si97exDwPxVLofLQsNnAbVMeEpZmEqLmwLvwgS'
    client_secret = 'EMNBt5aJF-eURZOg6ZKGwNEqk7fDc9njHfTgfxW7nP_SNJYihIOetSPtH0KqJuVHj9d1kN_SumTUqKp5'
    environment = PayPal::SandboxEnvironment.new client_id, client_secret
    @client = PayPal::PayPalHttpClient.new environment
  end
end
