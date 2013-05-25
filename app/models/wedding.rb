class Wedding < ActiveRecord::Base
  attr_accessible :user_id

  belongs_to :user
  has_many :guests, dependent: :destroy
  has_many :expenditures, dependent: :destroy
  has_many :check_items, dependent: :destroy

  validates :user_id, presence: true

  after_create :init_expenditures

  def budget_cost
    expenditures.map(&:cost).inject(:+)
  end

  def budget_paid
    expenditures.map(&:paid).inject(:+)
  end

  def budget_to_pay
    budget_cost - budget_paid
  end

  private
  def init_expenditures
    expenditures.create
  end
end
