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
