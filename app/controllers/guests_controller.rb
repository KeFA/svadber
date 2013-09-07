class GuestsController < ApplicationController
  include GuestsHelper
  before_action :authenticate_user!

  respond_to :json

  def index
    respond_with guests
  end

  def create
    guest = guests.create
    respond_with guest
  end

  def update
    find_guest {|guest| guest.update_attributes(guest_params)}
  end

  def destroy
    find_guest {|guest| guest.destroy}
  end


  private

  def guests
    current_user.wedding.guests
  end

  def find_guest
    guest = guests.find_by_id(params[:id])
    if guest
      yield guest
    end

    render nothing: true
  end

  def guest_params
    params.require(:guest).permit(:city, :first_name, :last_name, :middle_name, :status)
  end
end
