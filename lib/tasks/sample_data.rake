namespace :db do
  task populate: :environment do
    60.times do
       Guest.create(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name,
                        middle_name: Faker::Name.first_name, city: 'Mozyr', status: 'guest')
    end
  end
end