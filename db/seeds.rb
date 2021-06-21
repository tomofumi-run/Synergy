# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

5.times do |n|
  User.create!(
    email: "test#{n + 1}@test.com",
    first_name: "太郎#{n + 1}",
    last_name: "田中#{n + 1}",
    profile_image: File.open('./app/assets/images/test1.jpg'),
    password: '123456',
    history_status: 10,
    prefecture_code: 27
  )
end

5.times do |n|
  User.create!(
    email: "test1#{n + 1}@test.com",
    first_name: "花子#{n + 1}",
    last_name: "山田#{n + 1}",
    profile_image: File.open('./app/assets/images/test3.jpg'),
    password: '123456',
    history_status: 7,
    prefecture_code: 23
  )
end

5.times do |n|
  User.create!(
    email: "test2#{n + 1}@test.com",
    first_name: "守#{n + 1}",
    last_name: "黒崎#{n + 1}",
    profile_image: File.open('./app/assets/images/test2.jpg'),
    password: '123456',
    history_status: 25,
    prefecture_code: 34
  )
end

5.times do |n|
  User.create!(
    email: "test3#{n + 1}@test.com",
    first_name: "優子#{n + 1}",
    last_name: "佐藤#{n + 1}",
    profile_image: File.open('./app/assets/images/test4.jpg'),
    password: '123456',
    history_status: 2,
    prefecture_code: 40
  )
end

5.times do |n|
  User.create!(
    email: "test4#{n + 1}@test.com",
    first_name: "恵#{n + 1}",
    last_name: "原田#{n + 1}",
    profile_image: File.open('./app/assets/images/test5.jpg'),
    password: '123456',
    history_status: 1,
    prefecture_code: 1
  )
end

Genre.create!(
  name: '書籍'
)

Genre.create!(
  name: 'ニュース'
)

Genre.create!(
  name: '質問'
)

Admin.create!(
  email: "admin@admin.com",
  password: 123456
)
3.times do |n|
  User.all.find_each do |user|
    user.posts.create!(
      genre_id: '3',
      post_image: File.open('./app/assets/images/kaeru.png'),
      title: '初任の悩み',
      content: '4月から小学校教員として働き始めました。業務終了後に教材研究をしておりますが、集中力も切れ始めている中だとうまくできません。皆さんはどのようにして教材研究を進めていますか？ご教授願います。'
    )
  end
end

3.times do |n|
  User.all.find_each do |user|
    user.posts.create!(
      genre_id: '1',
      post_image: File.open('./app/assets/images/post1.jpg'),
      title: '知識の宝',
      content: '教員として働く上での考え方や、子どもとの向き合い方を考えさせられる内容になっています。'
    )
  end
end

3.times do |n|
  User.all.find_each do |user|
    user.posts.create!(
      genre_id: '2',
      post_image: File.open('./app/assets/images/post2.jpg'),
      title: 'GIGAスクール構想のニュース',
      content: '子供たち一人ひとりに個別最適化され、創造性を育む教育ICT環境の実現に向けて、令和元年12月19日、文部科学大臣を本部長とする「GIGAスクール実現推進本部」を設置しました。'
    )
  end
end

