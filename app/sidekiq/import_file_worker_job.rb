class ImportFileWorkerJob
  include Sidekiq::Job

  queue_as :default

  def perform(*args)
    file = FileCnab.where(id: args)
    Cnabs::Imports::Creator.run(file)
  end
end
