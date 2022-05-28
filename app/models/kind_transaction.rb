class KindTransaction < ApplicationRecord
  enum nature: [:entrada, :saida]
  has_many :import_files
end
