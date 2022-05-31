FactoryBot.define do
  factory :user do
    name     { Faker::JapaneseMedia::OnePiece.character }
    email    { Faker::Internet.email }
    password { 123_456 }
    password_confirmation { 123_456 }
  end
end