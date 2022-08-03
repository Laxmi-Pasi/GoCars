class HomeController < ApplicationController
  def home
    @cars = Car.where()
  end
end
