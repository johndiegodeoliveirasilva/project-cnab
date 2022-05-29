class Base
  def message_error(line, point)
    return point if point.eql?(Cnabs::Process::Validations::MAP_METHOD.key("total_size"))
    "Erro na verificação, na linha #{line} contem errors, na posição #{point}"
  end

  def read_file(filecab)
    filecab.file.download.force_encoding("UTF-8")
  end

  def normalize_hour(hour)
    t = Time.new(0000, 1, 1) + hour(hour).to_i
    t.strftime("%H:%M:%S")
  end
end
