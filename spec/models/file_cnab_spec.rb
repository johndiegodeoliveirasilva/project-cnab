require 'rails_helper'

include ActionDispatch::TestProcess::FixtureFile
RSpec.describe FileCnab, type: :model do
  describe "valid model filecnab" do
    
    it "is valid with valid attributes" do
      expect(FileCnab.new).to be_valid
    end

    it "is not valid without title" do
      expect(FileCnab.new).to_not be_valid
    end

    it "is not valid without an attachment" do
      expect(FileCnab.new).to_not be_valid
    end
  end
end
