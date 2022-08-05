class CarsController < ApplicationController
  before_action :set_car, only: %i[ show edit update destroy ]
  authorize_resource
  skip_authorize_resource only: :set_dealer

  # GET /cars or /cars.json
  def index
    if current_user
     @cars = params[:my_cars] ? Car.where(owner_id: current_user.id) : Car.where.not(owner_id: current_user.id) 
    else
      @cars = Car.all
    end
  end

  # GET /cars/1 or /cars/1.json
  def show
  end

  # GET /cars/new
  def new
    if current_user.Secret_key==nil
      @user = current_user
      render :become_dealer
    else
      @car = Car.new
    end
  end

  def set_dealer
    # binding.pry
    @user = current_user
    @user.check_for_dealer = true
    if @user.update(dealer_params)
      redirect_to new_car_path
    else
      render :become_dealer, status: :unprocessable_entity
    end 
  end

  # GET /cars/1/edit
  def edit
  end

  # POST /cars or /cars.json
  def create
    @car = Car.new(car_params)

    validate_car(@car)

    respond_to do |format|
      if @car.save
        add_to_car(@car)
        @car.save
        format.html { redirect_to car_url(@car), notice: "Car was successfully created." }
        format.json { render :show, status: :created, location: @car }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @car.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cars/1 or /cars/1.json
  def update
    validate_car(@car)

      respond_to do |format|
        if @car.update(car_params)
          add_to_car(@car)
          @car.save
          format.html { redirect_to car_url(@car), notice: "Car was successfully updated." }
          format.json { render :show, status: :ok, location: @car }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @car.errors, status: :unprocessable_entity }
        end
    end
  end

  # DELETE /cars/1 or /cars/1.json
  def destroy
    @car.destroy
    respond_to do |format|
      format.html { redirect_to cars_url, notice: "Car was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  # DELETE /cars/1/car_image

  def delete_car_image
    @car = Car.find(params['id'])
    @car_image = @car.car_images.find(params['image_id'])
    @car_image.purge
    respond_to do |format|
      format.html { redirect_to @car, notice: 'car image was successfully destroyed.' }
    end
  end

  
  private

  def set_car
    @car = Car.friendly.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def car_params
    params.require(:car).permit(:company,:main_car_image, :model, :purchase_date, :engine_type, :car_type, :seats,:owner_id, :distance_driven, :transmission_type, :car_description, :registered_number, car_images: [])
  end

  def dealer_params
    params.require(:user).permit(:payment_gateway, :Secret_key, :Public_key)
  end

  # ------ To check optional validation -------
  def validate_car(car)
    if params[:car][:sell] == "1" && ( params[:car][:sell_price] == "" || params[:car][:sell_price] == "0" || params[:car][:sell_price] < "0" )
      car.sell_checked = true
      car.sell_price = nil
    end

    if params[:car][:rent] == "1" && ( params[:car][:rent_price] == "" || params[:car][:rent_price] == "0" || params[:car][:rent_price] < "0" )
      car.rent_checked = true
      car.rent_price = nil
    end

    if params[:car][:sell] == "0" && params[:car][:rent] == "0"
      car.invalid_purpose = true
      car.purpose.clear
    end
  end

  # ------- To add optional value to object -------
  def add_to_car(car)
    if params[:car][:sell] == "1"
      if !car.purpose.include?("sell")
        car.purpose.push("sell")
      end
      car.sell_price = params[:car][:sell_price]
    else
      car.purpose.delete("sell")
      car.sell_price = nil 
    end

    if params[:car][:rent] == "1"
      if !car.purpose.include?("rent")
        car.purpose.push("rent")
      end
      car.rent_price = params[:car][:rent_price]
    else
      car.purpose.delete("rent")
      car.rent_price = nil
    end
  end
end
