class Api::V1::CompaniesController < ApplicationController
  protect_from_forgery with: :null_session
  include Paginable
  before_action :define_company, only: %w[show]

  def index
    @q = Company.ransack(filters)
    @pagy, @company = pagy(@q.result.includes(import_files: [:kind_transaction]), items: per_page, page: current_page)

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

  def filters
    { 
      id_eq: params[:id],
      name_cont: params[:name],
      representative_name_cont: params[:representative_name],
      created_at_gteq: params[:created_at_gteq]&.to_date&.beginning_of_day,
      created_at_lteq: params[:created_at_lteq]&.to_date&.end_of_day
    }.reject {|_, value| value.eql?(nil) }
  end
end
