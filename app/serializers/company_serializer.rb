class CompanySerializer
  include JSONAPI::Serializer
  attributes :id, :name, :representative_name
  has_many :import_files
end
