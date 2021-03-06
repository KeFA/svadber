class TodosController < ApplicationController
  include ApplicationHelper

  respond_to :json
  before_action :authenticate_user!

  def index
    respond_with todos
  end

  def create
    todo = todos.create(todo_params)
    respond_with todo
  end

  def update
    todo = todos.find_by_id(params[:id])
    if todo
      todo.update_attributes(todo_params)
    end
    render nothing: true
  end

  def destroy
    todo = todos.find_by_id(params[:id])
    if todo
      todo.destroy
    end
    render nothing: true
  end

  private
    def todos
      current_user.wedding.todos
    end

    def todo_params
      params.require(:todo).permit(:description, :done)
    end
end