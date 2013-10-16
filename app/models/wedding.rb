class Wedding < ActiveRecord::Base
  belongs_to :user
  has_many :guests, dependent: :destroy
  has_many :expenditures, dependent: :destroy
  has_many :todos, dependent: :destroy
  has_many :cars, dependent: :destroy

  validates :user_id, presence: true

  after_create :init_expenditures

  private
  def init_expenditures
    expenditures.create
  end
end
