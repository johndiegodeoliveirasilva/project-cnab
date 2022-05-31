class ImportFilesController < Api::V1::ImportFilesController
  respond_to :html
  include Paginable
  before_action :define_import_file, only: %w[show]

  def index
    @q = ImportFile.ransack(filters)
    @pagy, @import_files = pagy(@q.result.includes(:company, :kind_transaction).all, items: per_page, page: current_page)
  end

  def show; end
end