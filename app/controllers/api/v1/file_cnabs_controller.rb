class Api::V1::FileCnabsController < ApplicationController
  include Paginable

  def index
    @q = FileCnab.ransack(filters)
    @pagy, @file_cnabs = pagy(@q.result(distinct: true), items: per_page, page: current_page)

    options = get_links_serializer_options(:api_v1_file_cnabs_path, @pagy)
    respond_to do |format|
      format.json { render json: FileCnabSerializer.new(@file_cnabs, options).serializable_hash }
      format.html
    end
  end

  def process_file
    return render json: "sem arquivo", status: :unprocessable_entity if params[:file].blank?
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

  private

  def filters
    { 
      id_eq: params[:id],
      title_cont: params[:title],
      status_eq: params[:status],
      created_at_gteq: params[:created_at_gteq]&.to_date&.beginning_of_day,
      created_at_lteq: params[:created_at_lteq]&.to_date&.end_of_day
    }.reject {|_, value| value.eql?(nil) }
  end
end
