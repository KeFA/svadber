class TodosController < ApplicationController
  include ApplicationHelper

  respond_to :json
  before_action :authenticate_user!


  def index
    respond_with Todo.all
  end
end