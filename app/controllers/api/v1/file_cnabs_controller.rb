class Api::V1::FileCnabsController < ApplicationController
  protect_from_forgery with: :null_session
  include Paginable

  def index
    @pagy, @file_cnabs = pagy(FileCnab.all, items: per_page, page: current_page)

    options = get_links_serializer_options(:api_v1_file_cnabs_path, @pagy)
    respond_to do |format|
      format.json { render json: FileCnabSerializer.new(FileCnab.all, options).serializable_hash }
      format.html
    end
  end

  def process_file
    resp = Cnabs::Process::UploadFile.run(params[:file])
    if resp.is_a?(FileCnab)
      ImportFileWorkerJob.perform_async(resp.id) 
      respond_to do |format|
        format.json { render json:  FileCnabSerializer.new(resp).serializable_hash }
        format.html
      end
    else
      respond_to do |format|
        format.html { render html: resp, status: :unprocessable_entity }
        format.json { render json: resp, status: :unprocessable_entity }
      end
    end
  end
end
