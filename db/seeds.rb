# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
  
  20.times do |n|
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
  
  User.create!(
    email: "kinpachi@test.com",
    first_name: "金八",
    last_name: "坂本",
    profile_image: File.open('./app/assets/images/kinpachi.jpeg'),
    password: "123456",
    history_status: 20,
    prefecture_code: 20,
    )
    
  User.create!(
    email: "suda@test.com",
    first_name: "将暉",
    last_name: "菅田",
    profile_image: File.open('./app/assets/images/suda.jpg'),
    password: "123456",
    history_status: 5,
    prefecture_code: 23,
    )
    
  User.create!(
    email: "chiba@test.com",
    first_name: "雄大",
    last_name: "千葉",
    profile_image: File.open('./app/assets/images/chiba.jpg'),
    password: "123456",
    history_status: 3,
    prefecture_code: 2,
    )
  
  User.create!(
    email: "abe@test.com",
    first_name: "寛",
    last_name: "阿部",
    profile_image: File.open('./app/assets/images/abe.jpg'),
    password: "123456",
    history_status: 15,
    prefecture_code: 35,
    )
  
  User.create!(
    email: "satou@test.com",
    first_name: "隆太",
    last_name: "佐藤",
    profile_image: File.open('./app/assets/images/satou.jpg'),
    password: "123456",
    history_status: 13,
    prefecture_code: 11,
    )
    
  User.create!(
    email: "eikura@test.com",
    first_name: "奈々",
    last_name: "榮倉",
    profile_image: File.open('./app/assets/images/eikura.jpg'),
    password: "123456",
    history_status: 2,
    prefecture_code: 9,
    )
    
  User.create!(
    email: "nakama@test.com",
    first_name: "由紀恵",
    last_name: "仲間",
    profile_image: File.open('./app/assets/images/nakama.jpg'),
    password: "123456",
    history_status: 10,
    prefecture_code: 2,
    )
  
  User.create!(
    email: "amami@test.com",
    first_name: "祐希",
    last_name: "天海",
    profile_image: File.open('./app/assets/images/amami.jpeg'),
    password: "123456",
    history_status: 14,
    prefecture_code: 4,
    )
  
  Genre.create!(
    name:"書籍"
    )
  
  Genre.create!(
    name:"ニュース"
    )
  
  Admin.create!(
    email: "admin@admin.com",
    password: "123456"
  )
  
  User.all.each do |user|
  user.posts.create!(
    genre_id: "1",
    post_image: File.open('./app/assets/images/kaeru.png'),
    title: 'タイトル',
    content: 'テキストテキストテキストテキストテキストテキストテキストテキストテキストテキストテキストテキストテキストテキストテキストテキスト',
    )
  end
  
  
  