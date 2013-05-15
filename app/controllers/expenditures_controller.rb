class ExpendituresController < ApplicationController
  include ApplicationHelper

  def index
    if sort_column != 'remain_to_paid'
      @expenditures = current_wedding.expenditures.order(sort_column + ' ' + sort_order)
    else
      @expenditures = current_wedding.expenditures.sort { |a, b| a.remain_to_paid <=> b.remain_to_paid }
      if sort_order == 'desc'
        @expenditures.reverse!
      end
    end
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

  def sort_column
    Expenditure.column_names.include?(params[:sort]) || params[:sort] == 'remain_to_paid' ? params[:sort] : 'id'
  end
end