FactoryBot.define do
  factory :file_cnab do
    title  { Faker::Name.name }
    status { Faker::Boolean.boolean }
  end
end
