class ImportFileSerializer
  include JSONAPI::Serializer
  attributes :id, :value, :cpf, :card, :data, :hour
  belongs_to :kind_transaction
  belongs_to :company
end
