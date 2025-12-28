module Tao
  module Lexer
    class ErrorHandler
      attr_reader :errors

      def initialize(scanner)
        @scanner = scanner
        @errors  = []
      end

      def add_error(type, lexeme = "")
        @errors << send(type, lexeme)
      end

      alias_method :add, :add_error

      def pos_get
        @scanner.pos.dup
      end
    end
  end
end
