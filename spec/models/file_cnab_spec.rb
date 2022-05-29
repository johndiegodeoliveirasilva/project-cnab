require 'rails_helper'

include ActionDispatch::TestProcess::FixtureFile
RSpec.describe FileCnab, type: :model do

  let(:file_cnab) { create(:file_cnab, :with_attachment)}

  describe "valid model filecnab" do
    
    it "is not valid without title" do
      expect(FileCnab.new).to_not be_valid
    end

    it "is not valid without an attachment" do
      expect(FileCnab.new).to_not be_valid
    end

    it 'is valid with an attachment' do
      expect(file_cnab).to be_valid
    end
  end
end
