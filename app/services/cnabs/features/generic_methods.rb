module Cnabs
  module Features
    class GenericMethods
      def message_error(line, point)
        return point if point.eql?(Valid::Validations::MAP_METHOD.key("total_size"))
        "Erro na verificação, na linha #{line} contem errors, na posição #{point}"
      end

      def read_file(filecab)
        filecab.file.download.force_encoding("UTF-8")
      end
    end
  end
end
