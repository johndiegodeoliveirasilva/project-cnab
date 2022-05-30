class Api::V1::ImportFilesController < ApplicationController
  protect_from_forgery with: :null_session
  include Paginable
  before_action :define_import_file, only: %w[show]

  def index
    @q = ImportFile.ransack(filters)
    @pagy, @import_files = pagy(@q.result.includes(:company, :kind_transaction).all, items: per_page, page: current_page)

    options = get_links_serializer_options(:api_v1_import_files_path, @pagy)
    respond_to do |format|
      format.json { render json: ImportFileSerializer.new(@import_files, options).serializable_hash }
      format.html
    end
  end

  def show
    options = { include: [:company, :kind_transaction] }
    respond_to do |format|
      format.json { render json: ImportFileSerializer.new(@import_file, options).serializable_hash }
      format.html
    end
  end

  private
  
  def define_import_file
    @import_file = ImportFile.find(params[:id])
  end

  def filters
    { 
      id_eq: params[:id],
      value_eq: params[:value],
      cpf_eq: params[:cpf],
      card_eq: params[:card],
      company_name_cont: params[:company_name],
      kind_transaction_kind_eq: params[:kind_transaction],
      signal_eq: params[:signal],
      data_qteq: params[:data_qteq]&.to_date&.beginning_of_day,
      data_lteq: params[:data_lteq]&.to_date&.end_of_day,
      hour_qteq: params[:hour_qteq],
      hour_lteq: params[:hour_lteq]
    }.reject {|_, value| value.eql?(nil) }
  end
end
