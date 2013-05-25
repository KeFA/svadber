class ChecklistController < ApplicationController
  before_filter :authenticate_user!

  def index
    @check_items = current_user.wedding.check_items
  end

  def create
    puts 'kefa'
    CheckItem.create
  end
end
