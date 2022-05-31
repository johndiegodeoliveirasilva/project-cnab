require 'rails_helper'
require_relative '../../../support/api_helper'
include ApiHelper

include ActionDispatch::TestProcess::FixtureFile
RSpec.describe Api::V1::FileCnabsController, type: :controller do
  describe "FileCnabs" do
    let(:user) { create(:user)}
    before do
      authenticated_header(request, user)
    end
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

      describe 'filter' do
        let(:file_cnab) { create(:file_cnab, :with_attachment, status: false, title: "empresario.txt", created_at: Date.new(1997, 01, 01)) }

        it 'should filter file_cnabs by title' do
          get :index, params: { title: file_cnab.title}, format: :json
          expect(json_response.dig(:data).count).to eq(1)
        end

        it 'should filter file_cnabs by dates' do
          get :index, params: { created_at_gteq: file_cnab.created_at, created_at_lteq: file_cnab.created_at}, format: :json
          expect(json_response.dig(:data).count).to eq(1)
        end
      
        it 'should filter file_cnabs by dates' do
          get :index, params: { status: file_cnab.status }, format: :json
          expect(json_response.dig(:data).count).to eq(1)
        end
        it 'should not filter file_cnabs by title' do
          get :index, params: { title: "Monk.D Luffy"}, format: :json
          expect(json_response.dig(:data).count).to eq(0)
        end
      end
    end
  end
end
