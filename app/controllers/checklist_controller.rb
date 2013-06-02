class ChecklistController < ApplicationController
  include ApplicationHelper
  before_filter :authenticate_user!

  def index
    @check_items = check_items.order(sort_column + ' ' + sort_order)
  end

  def create
    @check_item = check_items.create

    respond_to do |format|
      format.js
    end
  end

  def update
    check_item = check_items.find_by_id(params[:id])
    if check_item
      check_item.update_attributes(params[:check_item])
    end
    render nothing: true
  end

  def destroy
    check_item = check_items.find_by_id(params[:id])
    if check_item
      check_item.destroy
      @check_items = check_items
    end

    respond_to do |format|
      format.html {render :index}
      format.js
    end
  end

  private
  def check_items
    current_user.wedding.check_items
  end

  def sort_column
    CheckItem.column_names.include?(params[:sort]) ? params[:sort] : 'id'
  end
end
