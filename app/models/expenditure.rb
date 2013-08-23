class Expenditure < ActiveRecord::Base
  belongs_to :wedding

  validates :wedding_id, presence: true

  def remain_to_paid
    cost - paid
  end
end
