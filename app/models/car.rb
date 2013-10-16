class Car < ActiveRecord::Base
  belongs_to :wedding
  validates :wedding_id, presence: true

  def as_json(options = {})
    super(except: [:created_at, :updated_at, :wedding_id]).merge(cost: cost, remain_to_pay: remain_to_pay)
  end

  def cost
    cost_for_hour * hours_count + cost_for_decorations
  end

  def cost_for_hour
    read_attribute(:cost_for_hour) || 0
  end

  def hours_count
    read_attribute(:hours_count) || 0
  end

  def cost_for_decorations
    read_attribute(:cost_for_decorations) || 0
  end

  def paid
    read_attribute(:paid) || 0
  end

  def remain_to_pay
    cost - paid
  end
end
