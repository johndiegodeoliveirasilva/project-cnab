require 'rails_helper'

RSpec.describe Company, type: :model do

  let(:without_representive) { build(:company, :without_representive) }
  let(:company) { build(:company) }

  describe "valid model company" do
    it "is not valid without name" do
      expect(Company.new).to_not be_valid
    end

    it "is not valid without an representative_name" do
      expect(without_representive).to_not be_valid
    end

    it 'is valid' do
      expect(company).to be_valid
    end
  end
end
