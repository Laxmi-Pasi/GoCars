class PaypalPsp < Psp
  has_many :car_transactions
  
  def sell_car(transaction_id)
    paypal_init(transaction_id)
    price = @transaction.car.sell_price
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
    paypal_init(car_transaction_id)
    request = PayPalCheckoutSdk::Orders::OrdersCaptureRequest::new transaction_token
    begin
      response = @client.execute request
      
      binding.pry
      
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
  def paypal_init(transaction_id)
    @transaction = CarTransaction.find(transaction_id)
    client_id = @transaction.owner.Public_key
    client_secret = @transaction.owner.Secret_key
    environment = PayPal::SandboxEnvironment.new client_id, client_secret
    @client = PayPal::PayPalHttpClient.new environment
  end
end
