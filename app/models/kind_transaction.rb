class KindTransaction < ApplicationRecord
  enum nature: [:entrada, :saida]
  has_many  :import_files
  validates :description, presence: true
  validates :nature, presence: true
  validates :signal, presence: true
end
