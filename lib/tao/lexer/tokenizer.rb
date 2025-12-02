module Tao
  module Lexer
    class Tokenizer
      def initialize
        @scanner = Scanner.new
      end

      def bool_token?(str)
        str == 'True' || str == 'False'
      end

      def none_token?(str)
        str == 'None'
      end
    end
  end
end
