require 'rails_helper'
include ActionDispatch::TestProcess::FixtureFile
RSpec.describe Api::V1::FileCnabsController, type: :controller do
  describe "FileCnabs" do
    describe "POST #process_file" do
      let(:title) { "CNAB.txt" }
      context "success" do
        before do 
          post :process_file, params: {
            name: title,
            file: fixture_file_upload("spec/support/assets/files/CNAB.txt")
          }, format: :json
        end
        it { expect(response).to have_http_status(:ok) }
        it { expect(FileCnab.count).to eq(1) }
        it { expect(FileCnab.last.title).to eq(title) }
      end

      context "failure" do
        before do
          post :process_file, params: {
            name: title,
            file: fixture_file_upload("spec/support/assets/files/CNAB01.txt")
          }, format: :json
        end

        it { expect(response).to have_http_status(:unprocessable_entity) }
        it { expect(response.body).to eq("Arquivo corrompido.") }
      end
    end

    describe "GET #index" do
      before do
        create_list(:file_cnab, 7, :with_attachment)
      end

      let(:json_response) { JSON.parse(response.body, symbolize_names: true)}
      context 'page in range' do
        
        before do
          get :index, format: :json
        end
        it { expect(response.status).to eq(200) }
        it { expect(json_response.dig(:links, :first)).to be_truthy }
        it { expect(json_response.dig(:links, :last)).to be_truthy }
        it { expect(json_response.dig(:links, :prev)).to be_truthy }
        it { expect(json_response.dig(:links, :next)).to be_truthy }
      end

      context 'page out range' do
        before do
          get :index, params: { page: 8 }, format: :json
        end
        
        it { expect(response.status).to eq(200) }
        it { expect(json_response.dig(:links, :last)).to be_truthy }
        it { expect(json_response.dig(:links, :prev)).to be_truthy }
        it { expect(json_response.dig(:links, :next)).to be_truthy }
      end
    end
  end
end
