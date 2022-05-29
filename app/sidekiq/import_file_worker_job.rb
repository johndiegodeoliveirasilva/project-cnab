class ImportFileWorkerJob
  include Sidekiq::Job

  queue_as :default

  def perform(*args)
    Cnabs::Imports::Creator.run(args)
  end
end
