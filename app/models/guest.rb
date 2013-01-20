class Guest < ActiveRecord::Base
  attr_accessible :city, :first_name, :last_name, :middle_name, :status, :wedding_id

  belongs_to :wedding

  validates :wedding_id, presence: true
end