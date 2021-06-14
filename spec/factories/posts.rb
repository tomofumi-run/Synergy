FactoryBot.define do
 factory :post do
    post_image_id{ Faker::Lorem.characters(number:10) } ##画像を入れるには？
    genre_id { 1 }
    title { Faker::Lorem.characters(number: 10) }
    content { Faker::Lorem.characters(number: 30)}
    genre #アソシエーション
 end
end