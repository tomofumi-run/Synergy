FactoryBot.define do
  factory :user do
    last_name { "坂本" }
    first_name { "金八" }
    prefecture_code { 5 }
    history_status { 5 }
    email { "kinpachi@hito.com" }
    password { "123456" }
    password_confirmation { "123456" }
  end
end