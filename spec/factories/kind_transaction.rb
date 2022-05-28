FactoryBot.define do
  factory :kind_transaction do
    kind { rand(1..9)}
    description { Faker::Name.name_with_middle }
    nature { ["entrada", "saida"].sample }
    signal { ["+", "-"].sample }
  end
end
