module Cnabs
  module CommonFields
    class Fields < Features::GenericMethods
      def kind(args)
        args[0]
      end

      def date(args)
        args[1..8]
      end

      def value(args)
        args[9..18]
      end

      def document(args)
        args[19..29]
      end

      def card(args)
        args[30..41]
      end

      def hour(args)
        args[42..47]
      end

      def representant(args)
        args[48..61]
      end

      def name_company(args)
        args[62..80]
      end
    end
  end
end