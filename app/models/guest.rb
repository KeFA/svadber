class Guest < ActiveRecord::Base
  attr_accessible :city, :first_name, :last_name, :middle_name, :status
end
