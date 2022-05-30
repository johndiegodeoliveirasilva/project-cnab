require 'rails_helper'
RSpec.describe Api::V1::ImportFilesController, type: :controller do
  describe "Import Files" do
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

      describe 'filter' do
        let(:import_file) { create(:import_file, value: 0.1, cpf: "41315599007",
          data: Date.new(1997, 01, 01), hour: Time.new.strftime("%H:%M:%S")) }
      
        it 'should filter import_files by value' do
          get :index, params: { value: import_file.value}, format: :json
          expect(json_response.dig(:data).count).to eq(1)
        end
      
        it 'should filter import_files by cpf' do
          get :index, params: { cpf: import_file.cpf}, format: :json
          expect(json_response.dig(:data).count).to eq(1)
        end
      
        it 'should filter import_files by card' do
          get :index, params: { card: import_file.card, created_at_lteq: import_file.created_at}, format: :json
          expect(json_response.dig(:data).count).to eq(1)
        end

        it 'should filter import_files by data' do
          get :index, params: { data_qteq: import_file.data, data_lteq: import_file.data}, format: :json
          expect(json_response.dig(:data).count).to eq(1)
        end

        it 'should filter import_files by hour' do
          get :index, params: { hour_qteq: import_file.hour, hour_lteq: import_file.hour}, format: :json
          expect(json_response.dig(:data).count).to eq(1)
        end

        it 'should filter import_files by name company' do
          get :index, params: { company_name: import_file.company.name}, format: :json
          expect(json_response.dig(:data).count).to eq(1)
        end

        it 'should filter import_files by kind_transaction' do
          get :index, params: { kind_transaction: import_file.kind_transaction.kind}, format: :json
          expect(json_response.dig(:data)).to be_truthy
        end
        it 'should not filter import_files by cpf' do
          get :index, params: { cpf: "Monk.D Luffy"}, format: :json
          expect(json_response.dig(:data).count).to eq(0)
        end
      end
    end

    describe "GET import_files#show" do

      let(:import_file) { create(:import_file) }
      it "should show import_file" do
        get :show, params: { id: import_file}, format: :json
        expect(response.status).to eq(200)
        expect(import_file.company.id.to_s).to eq(json_response.dig(:data, 
        :relationships, :company, :data, :id))
        expect(import_file.company.name).to eq(json_response.dig(:included, 0, :attributes, :name))
      end
    end
  end
end
