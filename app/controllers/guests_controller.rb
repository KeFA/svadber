class GuestsController < ApplicationController
  def index
    @guest = Guest.new
    @guests = Guest.all.reverse!
  end

  def create
    @guest = Guest.new(params[:guest])
    if @guest.save
      flash.now[:info] = t(:guest_created)
      @guest = Guest.new
    else
      flash.now[:error] = t(:guest_creating_error)
    end
    @guests = Guest.all.reverse!
    render :index
  end

  def update
    guest = Guest.find(params[:id])
    guest.update_attributes(params[:guest])
    render nothing: true
  end
end
