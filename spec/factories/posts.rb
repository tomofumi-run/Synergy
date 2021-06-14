FactoryBot.define do
 factory :post do
    genre_id { 1 }
    post_image_id { Faker::Avatar.image } #画像の入れ込み方
    title { Faker::Lorem.characters(number: 10) }
    content { Faker::Lorem.characters(number: 30)}
 end
end