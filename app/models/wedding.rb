class Wedding < ActiveRecord::Base
  attr_accessible :user_id

  belongs_to :user
  has_many :guests, dependent: :destroy
  has_many :expenditures, dependent: :destroy

  validates :user_id, presence: true
end