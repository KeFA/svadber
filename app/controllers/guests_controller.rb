class GuestsController < ApplicationController
  include GuestsHelper
  before_action :authenticate_user!

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
      guest.update_attributes(guest_params)
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
    def sort_column
      Guest.column_names.include?(params[:sort]) ? params[:sort] : 'id'
    end

    def init_page_vars
      @guests = guests.order(sort_column + ' ' + sort_order)
      @statuses = guest_statuses
    end

    def guest_params
      params.require(:guest).permit(:city, :first_name, :last_name, :middle_name, :status, :wedding_id)
    end
end
