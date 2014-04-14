class Expenditure < ActiveRecord::Base
  belongs_to :wedding

  before_create :set_default_values
  validates :wedding_id, presence: true

  def as_json(options = {})
    super(except: [:created_at, :updated_at, :wedding_id]).merge(remain_to_pay: cost - paid, type: :expenditure)
  end

  private

  def cost
    read_attribute(:cost) || 0
  end

  def paid
    read_attribute(:paid) || 0
  end

  def set_default_values
    write_attribute(:description, '...')
  end
end
