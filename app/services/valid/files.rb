module Services
  class Valid::Files < Valid::Validations
    attr_accessor :file
    def initialize(file)
      @file = file
    end

    def self.run(file)
      new(file).run
    end

    def run
      process
    end
    private

    def process
      file.lines.each_with_index do |val, index|
        resp = valid_fields(val)
        return message_error(index + 1, resp[1]) if resp.is_a?(Array)
      end
      return true
    end

    def message_error(line, point)
      "Erro na verificação, na linha #{line} contem errors, entre a linha #{point}"
    end
  end
end
