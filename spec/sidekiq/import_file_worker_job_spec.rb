require 'rails_helper'
Sidekiq::Testing.fake!

RSpec.describe 'ImportFileWorkerJob', type: :job do
  describe '' do
    let(:file_cnab) { create(:file_cnab, :with_attachment)}
    it 'enqueues the notification worker' do
      expect {
        ImportFileWorkerJob.perform_async(file_cnab.id)
      }.to change(ImportFileWorkerJob.jobs, :size).by(1)
    end
  end
end
