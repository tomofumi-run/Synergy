FactoryBot.define do
  factory :contact do
    name { Faker::Lorem.characters(number: 10) }
    email { Faker::Internet.email(name: 'contact') }
    subject { Faker::Lorem.characters(number: 10) }
    message { Faker::Lorem.characters(number: 20) }
  end
end