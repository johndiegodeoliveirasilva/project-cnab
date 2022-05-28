module Process
  class UploadFile
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
      filecab = FileCnab.new(title: title, status: true)
      filecab.file.attach(file)
      Valid::Files.run(read_file(filecab)) if filecab.save
    end

    def read_file(filecab)
      filecab.file.download.force_encoding("UTF-8")
    end
  end
end
