# frozen_string_literal: true

FactoryBot.define do
  factory :genre do
    name { '書籍' }
  end
  factory :other_genre do
    name { 'ニュース' }
  end
end
