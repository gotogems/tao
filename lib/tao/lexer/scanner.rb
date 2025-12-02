module Tao
  module Lexer
    class Scanner
      include PositionTracking

      def initialize(source)
        @source = source
        @current = 0
        init_pos
      end

      def alpha_numeric?(ch)
        alpha_char?(ch) || digit_char?(ch)
      end

      def alpha_char?(ch)
        ('A' <= ch && ch <= 'Z') ||
        ('a' <= ch && ch <= 'z') ||
        ('_' == ch)
      end

      def digit_char?(ch)
        '0' <= ch && ch <= '9'
      end

      def peek
        return "\0" if at_end?
        @source[@current]
      end

      def peek_next
        if @current.next < @source.length
          @source[@current.next]
        else
          "\0"
        end
      end

      def advance(step = 1)
        char = @source[@current]
        @current += step
        char
      end

      def at_end?
        @source[@current].nil?
      end
    end
  end
end
