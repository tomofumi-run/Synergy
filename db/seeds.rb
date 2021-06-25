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
    profile_image: File.open('./app/assets/images/test.jpg'),
    password: '123456',
    history_status: 10,
    prefecture_code: 27,
    introduction: "こんにちは。教員をしています。多くのことを皆さんと学びたいと考えて登録しております。どうぞよろしくお願いいたします。"
  )
end

  User.create!(
    email: "itou@test.com",
    first_name: "博文",
    last_name: "伊藤",
    profile_image: File.open('./app/assets/images/itou.jpg'),
    password: '123456',
    history_status: 20,
    prefecture_code: 27,
    introduction: "明治時代に4度にわたって内閣制度発足以降の内閣総理大臣を務めていました。皆さんと学びを共有出来れば良いなと考えています。"
  )

  User.create!(
    email: "ookuma@test.com",
    first_name: "重信",
    last_name: "大隈",
    profile_image: File.open('./app/assets/images/ookuma.jpg'),
    password: '123456',
    history_status: 15,
    prefecture_code: 23,
    introduction: "武士から色々あって総理大臣になった経験があります。早稲田大学という学校も創りました。学校教育に関心があるので、気になる方を見つけたらフォローさせて頂きます。"
  )

  User.create!(
    email: "tuda@test.com",
    first_name: "梅子",
    last_name: "津田",
    profile_image: File.open('./app/assets/images/tuda.jpg'),
    password: '123456',
    history_status: 2,
    prefecture_code: 34,
    introduction: "岩倉使節団に随行して6歳で渡米したことがあります。女性教育に関心があり、現在の津田塾大学を創りました。女性にも学びの機会を保障していくためにこれからも行動していきます。"
  )

  User.create!(
    email: "kanou@test.com",
    first_name: "治五郎",
    last_name: "嘉納",
    profile_image: File.open('./app/assets/images/kanou.jpg'),
    password: '123456',
    history_status: 25,
    prefecture_code: 40,
    introduction: "東洋初のIOC委員に選ばれました。柔道・スポーツ・教育分野の発展や日本のオリンピック初参加に尽力した経験を生かして子どもたちの心の教育にも力を入れていくことが大切だと考えています。"
  )

  User.create!(
    email: "nitobe@test.com",
    first_name: "稲造",
    last_name: "新戸部",
    profile_image: File.open('./app/assets/images/nitobe.jpg'),
    password: '123456',
    history_status: 5,
    prefecture_code: 1,
    introduction: "私の著書[武士道]に全てが書いてあります。「武士道は知識を重んじるものではない。重んずるものは行動である。」若輩者ですが、どうぞよろしくお願いいたします。"
  )
  
  User.create!(
    email: "fukuzawa@test.com",
    first_name: "諭吉",
    last_name: "福沢",
    profile_image: File.open('./app/assets/images/fukuzawa.jpg'),
    password: '123456',
    history_status: 23,
    prefecture_code: 9,
    introduction: "武士、蘭学者、著述家、啓蒙思想家、教育者とか色々やってきました。慶應義塾大学という学校も創りました。これからの時代に合った学校を新たに創りたいと考えているところです。"
  )
  User.create!(
    email: "mori@test.com",
    first_name: "有礼",
    last_name: "森",
    profile_image: File.open('./app/assets/images/arimori.jpg'),
    password: '123456',
    history_status: 1,
    prefecture_code: 9,
    introduction: "明治六大教育家の一人です。アメリカの有識者に日本の教育について意見を求めたりしてきた経験もあり、日本と海外教育の良い部分を取り入れていく教育を目指しています。"
  )

  User.create!(
    email: "simoda@test.com",
    first_name: "歌子",
    last_name: "下田",
    profile_image: File.open('./app/assets/images/simoda.jpg'),
    password: '123456',
    history_status: 23,
    prefecture_code: 32,
    introduction: "オックスフォード大卒。歌人でもあり、教育者です。女子教育の先駆者として現在も活動中。"
  )

  User.create!(
    email: "ishii@test.com",
    first_name: "筆子",
    last_name: "石井",
    profile_image: File.open('./app/assets/images/ishii.jpg'),
    password: '123456',
    history_status: 7,
    prefecture_code: 17,
    introduction: "こんにちは。日本初の知的障害者福祉の創始者の一人である石井筆子です。学園長経験もあります。"
  )  

  User.create!(
    email: "noguchi@test.com",
    first_name: "英世",
    last_name: "野口",
    profile_image: File.open('./app/assets/images/noguchi.jpg'),
    password: '123456',
    history_status: 3,
    prefecture_code: 29,
    introduction: "主に細菌学の研究に従事しております。科学はとても楽しい科目です。"
  )

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
      post_image: File.open('./app/assets/images/question.jpg'),
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

