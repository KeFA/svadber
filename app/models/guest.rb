class Guest < ActiveRecord::Base
  attr_accessible :city, :first_name, :last_name, :middle_name, :status

  validates :last_name, presence: true
end
