FactoryBot.define do
 factory :post do
    genre_id { 1 }
    post_image_id { Rack::Test::UploadedFile.new(File.join(Rails.root, 'assets/images/abe.jpg'), 'images/jpg')}
    title { Faker::Lorem.characters(number: 10) }
    content { Faker::Lorem.characters(number: 30)}
 end
end