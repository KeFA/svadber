class Guest < ActiveRecord::Base
  attr_accessible :city, :first_name, :last_name, :middle_name, :status

  belongs_to :wedding

  validates :last_name, presence: true
  validates :wedding_id, presence: true
end