FactoryBot.define do
 factory :post do
    post_image { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/image.png'), 'image/png') }
    genre_id { 1 }
    title { Faker::Lorem.characters(number: 10) }
    content { Faker::Lorem.characters(number: 30)}
    genre
 end
end