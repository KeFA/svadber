class GuestsController < ApplicationController
  include GuestsHelper
  before_filter :authenticate_user!

  def index
    @guest = new_guest
    @guests = guests
  end

  def create
    @guest = new_guest(params[:guest])
    if @guest.save
      flash.now[:info] = t(:guest_created)
      @guest = new_guest
    else
      flash.now[:error] = t(:guest_creating_error)
    end
    @guests = guests
    render :index
  end

  def update
    guest = guests.find(params[:id])
    guest.update_attributes(params[:guest])
    render nothing: true
  end
end
