FactoryBot.define do
 factory :post do
    genre_id { 1 }
    attach_file { "post[post_image]" } "app/assets/images/abe.jpg"
    title { Faker::Lorem.characters(number: 10) }
    content { Faker::Lorem.characters(number: 30)}
 end
end