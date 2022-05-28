require "cpf_cnpj"

module Services
  class Valid::Validations < CommonFields::Fields

    MAP_METHOD = { 
      "Arquivo corrumpido." => "total_size",
      "1" => "kind_transaction",
      "2..9" => "date_transaction",
      "10..19" => "value_transaction",
      "20..30" => "document_transaction",
      "31..42" => "card_transaction",
      "43..48" => "hour_transaction",
      "49..62" => "representant_transaction",
      "63..81" => "name_company_transaction",
    }.freeze

    def valid_fields(args)
      MAP_METHOD.each do |key, value|
        return [false, key] unless send(value, args)
      end
      return true
    end

    def kind_transaction(args)
      kind(args).to_i.in?(1..9)
    end

    def date_transaction(args)
      date(args).size.eql?(8)
    end

    def value_transaction(args)
      value_cash = value(args)
      (value_cash.to_f / 100.00) > 0.0 && value_cash.size.eql?(10)
    end

    def document_transaction(args)
      cpf = document(args)
      CPF.valid?(cpf) && cpf.size.eql?(11) 
    end

    def card_transaction(args)
      card(args).size.eql?(12)
    end

    def hour_transaction(args)
      hour(args).size.eql?(6)
    end

    def representant_transaction(args)
      representant(args).size.eql?(14)
    end

    def name_company_transaction(args)
      name_company(args).size.eql?(19)
    end
    
    def total_size(args)
      args.size.eql?(81)
    end
  end
end