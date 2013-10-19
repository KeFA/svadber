class Expenditure < ActiveRecord::Base
  belongs_to :wedding

  validates :wedding_id, presence: true

  def as_json(options = {})
    super(except: [:created_at, :updated_at, :wedding_id]).merge(remain_to_pay: cost - paid)
  end

  def cost
    read_attribute(:cost) || 0
  end

  def paid
    read_attribute(:paid) || 0
  end
end
