FactoryBot.define do
  factory :import_file do
    value { Faker::Number.decimal(l_digits: 3, r_digits: 3) }
    cpf { Faker::Number.leading_zero_number(digits: 11) }
    card { Faker::Number.leading_zero_number(digits: 12)}
    data { Faker::Time.between(from: DateTime.now - 1, to: DateTime.now) }
    hour { Faker::Time.between(from: DateTime.now - 1, to: DateTime.now) }
    association :kind_transaction
    association :company

    trait :less_or_equal_than_zero do
      value { 0.0 }
    end

    trait :without_cpf do
      cpf { nil }
    end

    trait :without_card do
      card { nil }
    end

    trait :without_data do
      data { nil }
    end

    trait :without_hour do
      hour { nil }
    end
  end
end
