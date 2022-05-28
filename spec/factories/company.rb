FactoryBot.define do
  factory :company do
    name  { Faker::Name.name }
    representative_name { Faker::Boolean.boolean }
  end
end
