FactoryBot.define do
  factory :kind_transaction do
    kind { rand(1..9)}
    description { Faker::Name.name_with_middle }
    nature { ["entrada", "saida"].sample }
    signal { ["+", "-"].sample }

    trait :without_description do
      description { nil }
    end

    trait :without_nature do
      nature { nil }
    end

    trait :without_signal do
      signal { nil }
    end
  end
end
