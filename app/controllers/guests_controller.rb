class GuestsController < ApplicationController
  def index
    @guest = Guest.new
    @guests = Guest.all
  end

  def create
    @guest = Guest.create(params[:guest])
    @guests = Guest.all

    render :index
  end
end
