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
    resp = Cnabs::Process::UploadFile.run(params[:file])
    if resp.is_a?(FileCnab)
      ImportFileWorkerJob.perform_async(resp.id) 
      respond_to do |format|
        format.html { render html: resp }
        format.json { render json: resp }
      end
    else
      respond_to do |format|
        format.html { render html: resp, status: :unprocessable_entity }
        format.json { render json: resp, status: :unprocessable_entity }
      end
    end
  
  end
end
