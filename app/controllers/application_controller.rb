class ApplicationController < ActionController::Base
  protect_from_forgery

  protected
  def sort_order
    %w(asc desc).include?(params[:order]) ? params[:order] : 'asc'
  end
end
