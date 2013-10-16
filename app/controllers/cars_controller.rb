class CarsController < ApplicationController
  before_action :authenticate_user!

  respond_to :json

  def index
    respond_with cars
  end

  def show
    respond_with cars.find_by_id(params[:id])
  end

  def create
    respond_with cars.create
  end

  def update
    find_car {|car| car.update_attributes(car_params)}
  end


  def destroy
    find_car {|car| car.destroy}
  end

  private

  def cars
    current_user.wedding.cars
  end

  def find_car
    car = cars.find_by_id(params[:id])
    if car
      yield car
    end

    render nothing: true
  end

  def car_params
    params.require(:car).permit(:driver, :phone_number, :hours_count, :cost_for_hour,
                               :cost_for_decorations, :paid, :seats_count, :description)
  end
end