require 'rails_helper'
RSpec.describe Api::V1::CompaniesController, type: :controller do
  describe "companies" do
    before do
      create_list(:import_file, 7)
    end
    let(:json_response) { JSON.parse(response.body, symbolize_names: true)}
    
    describe "GET import_files#index" do
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

    describe "GET import_files#show" do
      let(:company) { create(:company)}
      let!(:import_file) { create(:import_file, company_id: company.id) }

      it "should show import_file" do
        get :show, params: { id: company.id}, format: :json
        expect(response.status).to eq(200)
        expect(json_response.dig(:data, :attributes, :name)).to eq(company.name)
        expect(json_response.dig(:included, 0, :attributes, :card)).to eq(company.import_files.first.card)
      end
    end
  end
end
