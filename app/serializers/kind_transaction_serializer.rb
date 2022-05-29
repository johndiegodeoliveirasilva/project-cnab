class KindTransactionSerializer
  include JSONAPI::Serializer
  attributes :id, :kind, :description, :nature, :signal
end
