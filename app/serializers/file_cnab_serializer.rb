class FileCnabSerializer
  include JSONAPI::Serializer
  attributes :id, :title, :status
end
