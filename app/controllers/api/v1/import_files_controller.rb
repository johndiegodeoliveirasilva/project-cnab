class Api::V1::ImportFilesController < ApplicationController
  protect_from_forgery with: :null_session
  include Paginable
  before_action :define_import_file, only: %w[show]

  def index
    @pagy, @import_files = pagy(ImportFile.includes(:company, :kind_transaction).all, items: per_page, page: current_page)

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
end
