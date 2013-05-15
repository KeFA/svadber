class GuestsController < ApplicationController
  include GuestsHelper
  before_filter :authenticate_user!

  def index
    init_page_vars
  end

  def new
    @guest = guests.create
    init_page_vars
    respond_to do |format|
      format.html { redirect_to guests_path }
      format.js
    end
  end

  def update
    guest = guests.find_by_id(params[:id])
    if guest
      guest.update_attributes(params[:guest])
      init_page_vars
    end
    render nothing: true
  end

  def destroy
    guest = guests.find_by_id(params[:id])
    if guest
      guest.destroy
      init_page_vars
    end

    respond_to do |format|
      format.html { render :index }
      format.js
    end
  end

  private
  def init_page_vars
    @statuses = guest_statuses
  end
end
