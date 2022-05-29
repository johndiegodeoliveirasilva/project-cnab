class ImportFile < ApplicationRecord
  belongs_to :kind_transaction
  belongs_to :company
  validates :value, numericality: { greater_than_or_equal_to: 0.1 }
  validates :value, presence: true
  validates :cpf, presence: true
  validates :card, presence: true
  validates :data, presence: true
  validates :hour, presence: true
end
