# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


puts 'Creating test user...'
User.create(id: 234234, email: 'test@admin.by', password: 'warmoon', reset_password_token: nil, reset_password_sent_at: nil, remember_created_at: nil, sign_in_count: 1, current_sign_in_at: '2013-09-12 21:01:09', last_sign_in_at: '2013-09-12 21:01:09', current_sign_in_ip: '127.0.0.1', last_sign_in_ip: '127.0.0.1', created_at: '2013-09-12 21:01:09', updated_at: '2013-09-12 21:01:09')
