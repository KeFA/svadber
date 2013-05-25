class CheckItem < ActiveRecord::Base
  attr_accessible :description, :done, :wedding_id

  belongs_to :wedding
end
