class ExpendituresController < ApplicationController
  include ApplicationHelper
  before_action :authenticate_user!

  respond_to :json

  def index
    all_expenditures = expenditures.map { |exp| exp.as_json.merge(writable: true) }
    cars = current_user.wedding.cars.map do |car|
      car.as_json(only: [:id, :description, :paid]).merge(writable: false, type: :car)
    end

    respond_with all_expenditures.concat(cars)
  end

  def create
    respond_with expenditures.create
  end

  def update
    find_expenditure {|expenditure| expenditure.update_attributes(expenditure_params)}
  end

  def destroy
    find_expenditure { |expenditure| expenditure.destroy }
  end

  private

  def expenditures
    current_user.wedding.expenditures
  end

  def find_expenditure
    expenditure = expenditures.find_by_id(params[:id])
    if expenditure
      yield expenditure
    end
    render nothing: true
  end

  def expenditure_params
    params.require(:expenditure).permit(:cost, :paid, :description)
  end
end