# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
  
  10.times do |n|
    User.create!(
      email: "test#{n + 1}@test.com",
      first_name: "名前#{n + 1}",
      last_name: "苗字#{n + 1}",
      profile_image: File.open('./app/assets/images/test.jpg'),
      password: "123456",
      history_status: 2,
      prefecture_code: 2,
    )
  end
  
  Genre.create!(
    name:"書籍"
    )
  
  Genre.create!(
    name:"ニュース"
    )
  
  User.all.each do |user|
    user.posts.create!(
      genre_id: 1,
      title: 'タイトル',
      content: 'txtxtxtxtxtxtxtxtxt',
      post_image: open('./app/assets/images/kaeru.png'),
    )
  end
  
  Admin.create!(
    email: "admin@admin.com",
    password: "123456"
  )