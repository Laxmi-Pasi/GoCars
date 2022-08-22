class CarTransactionsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :authenticate_user!, only: %i[car_sell_payment]
  before_action :set_car

  # GET /car_transactions/:id/car_sell_payment
  def car_sell_payment
    session[:car_id] = @car.id
  end

  # POST /car_transactions/sell_payment ( for Buy )
  def sell_payment
    psp = Psp.find_or_create_by!(type: @car.payment_gateway?)
    transaction = CarTransaction.create!(car_id: @car.id, owner_id: @car.owner.id, psp_id:psp.id, buyer_id: current_user.id , status: "processing")
    response = transaction.psp.sell_car(transaction.id) 
    
    binding.pry
    
    respond_to do |format|
      if transaction.psp.type == "PaypalPsp"
        format.json { render :json => {:token => response.result.id}, :status => :ok }
      elsif transaction.psp.type == "StripePsp"
        @session = response
        format.js
      else
      end
    end
  end  

  # POST	/car_transactions/paypal_payment_response  ( Getting Response from Payment Gateways )
  def paypal_payment_response
    @car_transaction = CarTransaction.find(session[:transaction_id])
    response = @car_transaction.psp.payment_response(@car_transaction.id,params[:transaction_token])
    session[:transaction_id]= nil
    session[:car_id]= nil
    return render :json => {:status => response.result.status}, :status => :ok
  end

  private
  def set_car
    @car =  params[:id] ? Car.friendly.find(params[:id]) : Car.friendly.find(session[:car_id]) 
  end
end
