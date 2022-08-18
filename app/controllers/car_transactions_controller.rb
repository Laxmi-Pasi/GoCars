class CarTransactionsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_car, except: %i[car_sell_payment]
  
  def car_sell_payment
    @car=Car.friendly.find(params[:id])
    session[:car_id] = @car.id
  end

  def sell_payment
    binding.pry
    psp = Psp.find_or_create_by!(type: @car.payment_gateway?)
    transaction = CarTransaction.create!(car_id: @car.id, owner_id: @car.owner.id, psp_id:psp.id, buyer_id: current_user.id , status: "processing")
    session[:transaction_id]=transaction.id
    response = transaction.psp.sell_car(transaction.id) 
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

  def paypal_payment_response
    binding.pry
    @car_transaction = CarTransaction.find(session[:transaction_id])
    response = @car_transaction.psp.payment_response(@car_transaction.id,params[:transaction_token])
    return render :json => {:status => response.result.status}, :status => :ok
  end

  private
  def set_car
    @car = Car.friendly.find(session[:car_id])
  end
end
