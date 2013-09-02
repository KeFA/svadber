class Expenditure < ActiveRecord::Base
  belongs_to :wedding

  validates :wedding_id, presence: true

  def as_json(options = {})
    super(options).merge(remain_to_paid: cost - paid)
  end
end
