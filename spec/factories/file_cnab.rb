include ActionDispatch::TestProcess::FixtureFile
include ActiveStorage::Blob::Analyzable
FactoryBot.define do

  factory :file_cnab do
    title  { Faker::Name.name }
    status { Faker::Boolean.boolean }
    
    trait :with_attachment do
      file do
        arquive = Rails.root.join("spec", "support","assets", "files", "CNAB.txt")
        ActiveStorage::Blob.create_and_upload!(
          io: File.open(arquive, 'rb'),
          filename: 'CNAB.txt',
          content_type: 'image/jpeg'
        ).signed_id
      end
    end
  end

end
