class CarsController < ApplicationController
  before_action :set_car, only: %i[ show edit update destroy ]

  # GET /cars or /cars.json
  def index
    @cars = Car.all
  end

  # GET /cars/1 or /cars/1.json
  def show
  end

  # GET /cars/new
  def new
    @car = Car.new
  end

  # GET /cars/1/edit
  def edit
  end

  # POST /cars or /cars.json
  def create
    @car = Car.new(car_params)

    if params[:car][:sell] == "1" && ( params[:car][:sell_price] == "" || params[:car][:sell_price] == "0" || params[:car][:sell_price] < "0" )
      @car.sell_checked = true
    end

    if params[:car][:rent] == "1" && ( params[:car][:rent_price] == "" || params[:car][:rent_price] == "0" || params[:car][:rent_price] < "0" )
      @car.rent_checked = true
    end
    
    respond_to do |format|
      if @car.save
        if params[:car][:sell] == "1"
          @car.purpose.push("sell")
        end
    
        if params[:car][:rent] == "1"
          @car.purpose.push("rent")
        end
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
    respond_to do |format|
      if @car.update(car_params)
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
      @car = Car.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def car_params
      params.require(:car).permit(:company,:main_car_image, :model, :purchase_date, :engine_type, :car_type, :seats,:owner_id, :distance_driven, :transmission_type, :car_description, :registered_number, car_images: [])
    end
end
