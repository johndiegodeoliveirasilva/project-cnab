require "cpf_cnpj"

module Services
  class Valid::Validations

    MAP_METHOD = { 
      "Arquivo corrumpido." => "total_size",
      "1" => "type_transaction",
      "2..9" => "date",
      "10..19" => "value",
      "20..30" => "cpf",
      "31..42" => "card",
      "43..48" => "hour",
      "49..62" => "representant",
      "63..81" => "name_company",
    }.freeze

    def valid_fields(args)
      MAP_METHOD.each do |key, value|
        return [false, key] unless send(value, args)
      end
      return true
    end

    def type_transaction(args)
      args[0].to_i.in?(1..12)
    end

    def cpf(args)
      document = args[19..29]
      CPF.valid?(document) && document.size.eql?(11) 
    end

    def date(args)
      args[1..8].size.eql?(8)
    end

    def value(args)
      value_cash = args[9..18]
      (value_cash.to_f / 100.00) != 0.0 && value_cash.size.eql?(10)
    end

    def card(args)
      args[30..41].size.eql?(12)
    end

    def hour(args)
      args[42..47].size.eql?(6)
    end

    def representant(args)
      args[48..61].size.eql?(14)
    end

    def name_company(args)
      args[62..80].size.eql?(19)
    end
    
    def total_size(args)
      args.size.eql?(81)
    end
  end
end