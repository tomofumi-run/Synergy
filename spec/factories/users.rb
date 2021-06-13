FactoryBot.define do
  factory :user do
    last_name { Faker::Lorem.characters(number: 5) }
    first_name { Faker::Lorem.characters(number: 5) }
    prefecture_code { 5 }
    history_status { 5 }
    email { Faker::Internet.email }
    password { "123456" }
    password_confirmation { "123456" }
  end
  
  factory :other_user do
    id { 2 }
    last_name { Faker::Lorem.characters(number: 5) }
    first_name { Faker::Lorem.characters(number: 5) }
    prefecture_code { 5 }
    history_status { 5 }
    email { Faker::Internet.email }
    password { "123456" }
    password_confirmation { "123456" }
  end
end