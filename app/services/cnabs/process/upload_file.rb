module Cnabs
  module Process
    class UploadFile < Base 
      attr_accessor :file, :title

      def initialize(file)
        @file = file
        @title = file.original_filename
      end

      def self.run(file)
        new(file).run
      end

      def run
        process
      end

      private

      def process
        instance_file
      end

      def instance_file
        attachment = FileCnab.new(title: title, status: true)
        attachment.file.attach(file)
        attachment.save
        Process::Files.run(read_file(attachment))
        attachment
      rescue => e
        attachment.destroy
        e.message
      end
    end
  end
end
