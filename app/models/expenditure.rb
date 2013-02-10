class Expenditure < ActiveRecord::Base
  attr_accessible :cost, :paid, :description, :wedding_id
  belongs_to :wedding

  validates :wedding_id, presence: true

  def remain_to_paid
    cost - paid
  end
end
