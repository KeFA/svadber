FactoryGirl.define do
  sequence(:email) { |n| "person#{n}@example.com" }

  factory :user do
    email
    password 'password'
    password_confirmation 'password'
  end

  factory :wedding do
    user
  end

  factory :guest do
    wedding
    sequence(:first_name) { |n| "first name #{n}" }
    sequence(:last_name) { |n| "last name #{n}" }
    sequence(:middle_name) { |n| "middle name #{n}" }
    sequence(:city) { |n| "city #{n}" }
    sequence(:status) { |n| "status #{n}" }
  end

  factory :expenditure do
    wedding
    sequence(:cost) { |n| n * 1000 }
    description 'description'
  end

  factory :check_item do
    wedding
  end
end