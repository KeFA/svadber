class ExpendituresController < ApplicationController
  include ApplicationHelper

  def index
    @expenditures = current_wedding.expenditures
  end

  def create
    @expenditure = expenditures.create
    respond_to do |format|
      format.js
    end
  end

  def update
    @expenditure = expenditures.find_by_id(params[:id])
    if @expenditure
      @expenditure.update_attributes(params[:expenditure])
    else
      render nothing: true
    end
  end

  private
  def expenditures
    current_wedding.expenditures
  end
end