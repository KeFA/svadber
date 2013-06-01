class ChecklistController < ApplicationController
  include ApplicationHelper
  before_filter :authenticate_user!

  def index
    @check_items = check_items
  end

  def create
    @check_item = check_items.create

    respond_to do |format|
      format.js
    end
  end

  def destroy
    check_item = check_items.find_by_id(params[:id])
    if check_item
      check_item.destroy
      @check_items = check_items
    end

    respond_to do |format|
      format.html {render :index}
      #format.js
    end
  end

  private
  def check_items
    current_user.wedding.check_items
  end
end
