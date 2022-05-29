require 'rails_helper'
include ActionDispatch::TestProcess::FixtureFile
RSpec.describe Api::V1::FileCnabsController, type: :controller do
  describe "POST #process_file" do
    let(:title) { "CNAB.txt" }  
    context "success" do
      before do 
        post :process_file, params: { 
          name: title,
          file: fixture_file_upload("spec/support/assets/files/CNAB.txt")
        }, format: :json
      end
      it { expect(response.code).to eq("200") }
      it { expect(FileCnab.count).to eq(1) }
      it { expect(FileCnab.last.title).to eq(title) }
      it { expect(response.body.class).to eq(Hash) }
    end

    context "failure" do
      before do
        post :process_file, params: { 
          name: title,
          file: fixture_file_upload("spec/support/assets/files/CNAB01.txt")
        }, format: :json
      end

      it { expect(response.code).to eq("422") }
      it { expect(response.body).to eq("Arquivo corrompido.") }
    end
  end
end
