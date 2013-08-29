class Expenditure < ActiveRecord::Base
  belongs_to :wedding

  validates :wedding_id, presence: true
end
