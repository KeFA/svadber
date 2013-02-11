class ExpendituresController < ApplicationController
  def index
    @expenditures = current_user.wedding.expenditures
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
      render :nothing
    end
  end

  private
  def expenditures
    current_user.wedding.expenditures
  end
end