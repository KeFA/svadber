class Todo < ActiveRecord::Base
  belongs_to :wedding

  def as_json(options = {})
    super(except: [:created_at, :updated_at, :wedding_id])
  end
end
