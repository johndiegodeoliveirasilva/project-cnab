FactoryBot.define do
  factory :company do
    name  { Faker::Name.name }
    representative_name { Faker::Boolean.boolean }
  end

  trait :without_name do
    name { nil }
  end

  trait :without_representive do
    representative_name { nil }
  end
end
