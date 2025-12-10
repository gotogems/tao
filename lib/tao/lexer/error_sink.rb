module Tao
  module Lexer
    class ErrorSink
      attr_reader :errors

      def initialize(scanner)
        @scanner = scanner
        @errors  = []
      end

      def add_error(type, lexeme = "")
        @errors << send(type, lexeme)
      end

      def unterminated(_lexeme)
        UnterminatedString.new(pos_get)
      end

      def unexpected(char)
        UnexpectedChar.new(pos_get, char)
      end

      def invalid(str)
        IllegalToken.new(pos_get, str)
      end

      alias_method :add, :add_error

      def pos_get
        @scanner.pos.dup
      end
    end
  end
end
