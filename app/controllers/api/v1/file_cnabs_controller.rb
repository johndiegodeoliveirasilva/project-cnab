class Api::V1::FileCnabsController < ApplicationController
  protect_from_forgery with: :null_session
  def index
    @file_cnabs = FileCnab.all
    
    respond_to do |format|
      format.html
      format.json { render json: @file_cnabs}
    end
  end

  def process_file
    resp = ::Process::UploadFile.run(params[:file])
    render json: resp, status: :unprocessable_entity if !resp.is_a?(true)
  end
end
