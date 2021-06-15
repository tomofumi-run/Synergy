# frozen_string_literal: true

FactoryBot.define do
  factory :chat do
    talk { Faker::Lorem.characters(number: 140) }
    user
    room
  end
end
