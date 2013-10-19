class Guest < ActiveRecord::Base
  belongs_to :wedding

  validates :wedding_id, presence: true

  def as_json(options = {})
    super(options.merge(except: [:created_at, :updated_at, :wedding_id])).merge(full_name: full_name)
  end

  private

  def full_name
    "#{last_name} #{first_name} #{middle_name}"
  end

  def bed_cost
    read_attribute(:bed_cost) || 0
  end
end