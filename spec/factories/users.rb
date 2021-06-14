FactoryBot.define do
  factory :user do
    last_name { Faker::Lorem.characters(number: 5) }
    first_name { Faker::Lorem.characters(number: 5) }
    prefecture_code { 5 }
    history_status { 5 }
    email { Faker::Internet.email(name: 'kinpachi') }
    password { Faker::Internet.password(min_length: 6)}
    password_confirmation { password }
  end
  
  factory :other_user do
    last_name { Faker::Lorem.characters(number: 5) }
    first_name { Faker::Lorem.characters(number: 5) }
    prefecture_code { 11 }
    history_status { 2 }
    email { Faker::Internet.email(name: 'kinpachi') }
    password { Faker::Internet.password(min_length: 6)}
    password_confirmation { password }
  end
end