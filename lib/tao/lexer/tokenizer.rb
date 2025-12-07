require 'tao/lexer/internal/punctuation'
require 'tao/lexer/internal/operators'
require 'tao/lexer/keywords'
require 'tao/lexer/scanner'

module Tao
  module Lexer
    class Tokenizer
      extend Forwardable
      attr_reader :tokens

      def initialize(source)
        @scanner = Scanner.new(source)
        @tokens  = []
        @start   = 0
      end

      def scan_tokens
        loop do
          break if @scanner.at_end?
          @start = @scanner.pos.index
          scan_token
        end

        add_token(Token::EOF)
        @tokens
      end

      def scan_token
        char = @scanner.advance

        return if skip_whitespace(char)
        return if skip_comment(char)

        single_token(char) ||
        double_token(char) ||
        triple_token(char) ||
        nil
      end

      def skip_whitespace(char)
        if char == "\n"
          @scanner.pos.line += 1
          @scanner.pos.col = 1
          return true
        end

        whitespace?(char)
      end

      def skip_comment(char)
        if char == '/' && match_char?('/')
          loop do
            break if @scanner.peek == "\n"
            break if @scanner.at_end?
            @scanner.advance
          end

          true
        else
          false
        end
      end

      def_delegator :@scanner, :whitespace?
      def_delegator :@scanner, :alpha_numeric?
      def_delegator :@scanner, :alpha_char?
      def_delegator :@scanner, :digit_char?
      def_delegator :@scanner, :match_char?

      def bool_token?(str)
        str == 'True' || str == 'False'
      end

      def none_token?(str)
        str == 'None'
      end

      def punc_get(str)
        Internal::Punctuation[str]
      end

      def op_get(str)
        Internal::Operators[str]
      end
    end
  end
end
