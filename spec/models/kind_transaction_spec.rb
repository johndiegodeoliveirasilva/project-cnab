require 'rails_helper'

RSpec.describe KindTransaction, type: :model do
  let(:without_description) { build(:kind_transaction, :without_description)}
  let(:without_nature) { build(:kind_transaction, :without_nature) }
  let(:without_signal) { build(:kind_transaction, :without_signal)}
  let(:kind_transaction) { build(:kind_transaction)}

  describe "valid model kind_transaction" do
    it "is not valid without kind" do
      expect(described_class.new).to_not be_valid
    end

    it "is not valid without description" do
      expect(without_description).to_not be_valid
    end

    it 'is not valid without signal' do
      expect(without_signal).to_not be_valid
    end

    it 'is not valid without nature' do
      expect(without_signal).to_not be_valid
    end
    it 'is valid kind_transaction' do
      expect(kind_transaction).to be_valid
    end
  end
end
