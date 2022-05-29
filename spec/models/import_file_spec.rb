require 'rails_helper'

RSpec.describe ImportFile, type: :model do

  let(:less_than_zero) { build(:import_file, :less_or_equal_than_zero)}
  let(:import_file) { build(:import_file)}
  let(:cpf) { build(:import_file, :without_cpf)}
  let(:card) { build(:import_file, :without_card)}

  describe "valid model import_file" do
    
    it "is not valid without value" do
      expect(described_class.new).to_not be_valid
    end

    it "is not valid with value less or equal then zero" do
      expect(less_than_zero).to_not be_valid
    end

    it "is not valid without cpf" do
      expect(cpf).to_not be_valid
    end

    it 'is not valid without card' do
      expect(card).to_not be_valid
    end

    it 'is valid with value greater than 0.1' do
      expect(import_file).to be_valid
    end
  end
end
