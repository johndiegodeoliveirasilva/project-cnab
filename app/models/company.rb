class Company < ApplicationRecord
  has_many :import_files
  validates :name, presence: true
  validates :name, uniqueness: true
  validates :representative_name, presence: true
end
