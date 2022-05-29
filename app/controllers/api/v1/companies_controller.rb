class Api::V1::CompaniesController < ApplicationController
  protect_from_forgery with: :null_session
  include Paginable
  before_action :define_company, only: %w[show]

  def index
    @pagy, @company = pagy(Company.includes(import_files: [:kind_transaction]).all, items: per_page, page: current_page)

    options = get_links_serializer_options(:api_v1_import_files_path, @pagy)
    respond_to do |format|
      format.json { render json: CompanySerializer.new(@company, options).serializable_hash }
      format.html
    end
  end

  def show
    options = { include: [:import_files] }
    respond_to do |format|
      format.json { render json: CompanySerializer.new(@company, options).serializable_hash }
      format.html
    end
  end

  private
  
  def define_company
    @company = Company.find(params[:id])
  end
end
