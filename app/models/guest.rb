class Guest < ActiveRecord::Base
  belongs_to :wedding

  validates :wedding_id, presence: true

  def as_json(options = {})
    super(except: [:created_at, :updated_at, :wedding_id])
  end
end