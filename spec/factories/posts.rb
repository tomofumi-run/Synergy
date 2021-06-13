FactoryBot.define do
 factory :post do
    title { Faker::Lorem.characters(number: 10) }
    content { Faker::Lorem.characters(number: 30)}
    post_image_id{ Faker::Lorem.characters(number:10) } ##画像を入れるには？
    genre
    user
 end
end