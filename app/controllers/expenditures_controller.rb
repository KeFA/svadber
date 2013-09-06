class ExpendituresController < ApplicationController
  include ApplicationHelper
  before_action :authenticate_user!

  respond_to :json

  def index
    respond_with expenditures
  end

  def create
    expenditure = expenditures.create
    respond_with expenditure
  end

  def update
    @expenditure = expenditures.find_by_id(params[:id])
    if @expenditure
      @expenditure.update_attributes(expenditure_params)
    end
    render nothing: true
  end

  def destroy
    expenditure = expenditures.find_by_id(params[:id])
    if expenditure
      expenditure.destroy
    end
    render nothing: true
  end

  private
    def expenditures
      current_wedding.expenditures
    end

    def expenditure_params
      params.require(:expenditure).permit(:cost, :paid, :description)
    end
end