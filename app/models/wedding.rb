class Wedding < ActiveRecord::Base
  belongs_to :user
  has_many :guests, dependent: :destroy

  validates :user_id, presence: true
end