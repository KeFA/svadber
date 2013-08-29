class SvadberController < ApplicationController
  include ApplicationHelper
  before_action :authenticate_user!

  def todos
  end

  def budget
  end
end