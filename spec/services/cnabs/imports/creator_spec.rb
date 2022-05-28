require 'rails_helper'

RSpec.describe Cnabs::Imports::Creator, type: :service do
  describe "import file to create transactions" do
    let(:file_cnab) { create(:file_cnab, :with_file) }
    let(:file_cnabs) { create_list(:file_cnab, 2, :with_file)}
    it "when company don't exist" do
      expect { described_class.run([file_cnab]) }.to change { Company.count }.from(0).to(1)
      expect(FileCnab.count).to eq(1)
    end

    it 'when company exit and expect two import' do
      expect { described_class.run(file_cnabs) }.to change { ImportFile.count }.from(0).to(2)
      expect(Company.count).to eq(1)
    end
  end
end