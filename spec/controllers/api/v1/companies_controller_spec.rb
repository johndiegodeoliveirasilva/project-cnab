require 'rails_helper'
require_relative '../../../support/api_helper'
include ApiHelper

RSpec.describe Api::V1::CompaniesController, type: :controller do

  let(:user) { create(:user)}
  describe "companies" do
    before do
      create_list(:import_file, 7)
      authenticated_header(request, user)
      get :index, format: :json
    end

    let(:json_response) { JSON.parse(response.body, symbolize_names: true)}
    
    describe "GET import_files#index" do
      context 'page in range' do
       
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
        let(:company) { create(:company, name: "John Diego", representative_name: "Ichigo",
          created_at: Date.new(1997, 01, 01)) }

        it 'should filter companies by name' do
        
          get :index, params: { name: company.name}, format: :json
          expect(json_response.dig(:data).count).to eq(1)
        end

        it 'should filter companies by representative_name' do
          get :index, params: { representative_name: company.representative_name}, format: :json
          expect(json_response.dig(:data).count).to eq(1)
        end

        it 'should filter companies by dates' do
          get :index, params: { created_at_gteq: company.created_at, created_at_lteq: company.created_at}, format: :json
          expect(json_response.dig(:data).count).to eq(1)
        end

        it 'should not filter companies by name' do
          get :index, params: { name: "Monk.D Luffy"}, format: :json
          expect(json_response.dig(:data).count).to eq(0)
        end
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