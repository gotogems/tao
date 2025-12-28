require 'tao/lexer/errorhandler'
require 'tao/lexer/tokenizer'

module Tao
  module Lexer
    LexicalError = Struct.new(:pos, :lexeme)

    class UnterminatedString < LexicalError; end
    class UnexpectedChar     < LexicalError; end
    class IllegalToken       < LexicalError; end

    class ErrorSink < ErrorHandler
      def unterminated(_lexeme)
        UnterminatedString.new(pos_get)
      end

      def unexpected(char)
        UnexpectedChar.new(pos_get, char)
      end

      def invalid(str)
        IllegalToken.new(pos_get, str)
      end
    end

    def self.tokenize(source)
      Tokenizer.new(source)
    end
  end
end
