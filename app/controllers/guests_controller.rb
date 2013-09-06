class GuestsController < ApplicationController
  include GuestsHelper
  before_action :authenticate_user!

  respond_to :json

  def index
    respond_with guests
  end

  def new
  end

  def update
  end

  def destroy
  end


  private

  def guests
    current_user.wedding.guests
  end

  def init_page_vars
    @guests = guests.order(sort_column + ' ' + sort_order)
    @statuses = guest_statuses
  end

  def guest_params
    params.require(:guest).permit(:city, :first_name, :last_name, :middle_name, :status, :wedding_id)
  end
end
