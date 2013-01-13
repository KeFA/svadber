FactoryGirl.define do
  factory :guest do
    sequence(:first_name) { |n| "first name #{n}" }
    sequence(:last_name) { |n| "last name #{n}" }
    sequence(:middle_name) { |n| "middle name #{n}" }
    sequence(:city) { |n| "city #{n}" }
    sequence(:status) { |n| "status #{n}" }
  end
end