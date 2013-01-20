class GuestsController < ApplicationController
  include GuestsHelper
  before_filter :authenticate_user!

  def index
  end

  def new
    @guest = guests.create
    respond_to do |format|
      format.html { redirect_to guests_path }
      format.js
    end
  end

  def update
    guest = guests.find_by_id(params[:id])
    if guest
      guest.update_attributes(params[:guest])
    end
    render nothing: true
  end

  def destroy
    guest = guests.find_by_id(params[:id])
    if guest
      guest.destroy
    end

    respond_to do |format|
      format.html { render :index }
      format.js
    end
  end
end
