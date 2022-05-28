FactoryBot.define do
  factory :import_file do
    value { Faker::Number.decimal(l_digits: 3, r_digits: 3) }
    cpf { Faker::Number.leading_zero_number(digits: 11) }
    card { Faker::Number.leading_zero_number(digits: 12)}
    data { Faker::Time.between(from: DateTime.now - 1, to: DateTime.now) }
    hour { Faker::Time.between(from: DateTime.now - 1, to: DateTime.now) }
    association :kind_transaction
    association :company
  end
end
