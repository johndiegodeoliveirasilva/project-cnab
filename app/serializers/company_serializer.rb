class CompanySerializer
  include JSONAPI::Serializer
  attributes :id, :name, :representative_name
end
