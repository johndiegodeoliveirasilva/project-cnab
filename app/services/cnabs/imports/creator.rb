module Cnabs
  module Imports
    class Creator < Cnabs::CommonFields::Fields
      attr_accessor :files

      def initialize(files)
        @files = files
      end

      def self.run(files)
        new(files).run
      end

      def run
        process
      end

      private

      def process
        files.each do |file|
          read_file(file).lines do |line|
            company_record = create_or_find_company(line)
            create_transaction(company_record, line)
          end
        end
      end

      def create_or_find_company(line)
        Company.find_or_create_by(name: name_company(line)) do |company|
          company.representative_name = representant(line)
        end 
      end

      def create_transaction(company, line)
        ImportFile.create(
          value: value(line),
          cpf: document(line),
          card: card(line),
          data: date(line),
          hour: normalize_hour(line),
          kind_transaction_id: kind(line),
          company_id: company.id
        )
      end
    end
  end
end
