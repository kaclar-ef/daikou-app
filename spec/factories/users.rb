FactoryBot.define do
  factory :user do
    email           { Faker::Internet.email }
    password        { 'pass1234' }
    first_name      { '太郎' }
    last_name       { '田中' }
    first_name_kana { 'タロウ' }
    last_name_kana  { 'タナカ' }
    phone_number    { '09012345678' }
  end
end
