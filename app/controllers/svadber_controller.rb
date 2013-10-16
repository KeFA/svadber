class SvadberController < ApplicationController
  include ApplicationHelper
  before_action :authenticate_user!

  def todos
  end

  def budget
  end

  def seating
  end

  def guests
  end

  def cars
  end
end