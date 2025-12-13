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
        @sink    = ErrorSink.new(@scanner)
      end

      def next_token
        @stop_after_token = true
        @next_token = nil
        scan_tokens
        @stop_after_token = false
        @next_token
      end

      def scan_tokens
        loop do
          break if @scanner.at_end?
          @start = @scanner.pos.index
          @start_pos = @scanner.pos.dup

          if @next_token = scan_token
            break if @stop_after_token
          end
        end

        return if @stop_after_token
        add_token(Token::EOF)
        @tokens
      end

      def scan_token
        char = @scanner.advance

        return if skip_whitespace(char)
        return if skip_comment(char)

        case char
        when '+' then op_token('+')
        when '-' then op_token('-')
        when '*' then op_token('*')
        when '/' then op_token('/')
        when '%' then op_token('%')
        when '{' then punc_token('{')
        when '}' then punc_token('}')
        when '[' then punc_token('[')
        when ']' then punc_token(']')
        when '(' then punc_token('(')
        when ')' then punc_token(')')
        when ',' then punc_token(',')
        when ':' then punc_token(':')
        when ';' then punc_token(';')
        when '.' then punc_token('.')
        when '>'
          match_char?('=') ? op_token('>=') : op_token('>')
        when '<'
          match_char?('=') ? op_token('<=') : op_token('<')
        when '='
          match_char?('=') ? op_token('==') : op_token('=')
        when '!'
          match_char?('=') ? op_token('!=') : op_token('!')
        when '?'
          match_char?('.') ? op_token('?.') : op_token('?')
        when '&'
          if match_char?('&')
            match_char?('=') ? op_token('&&=') : op_token('&&')
          else
            op_token('&')
          end
        when '|'
          if match_char?('|')
            match_char?('=') ? op_token('||=') : op_token('||')
          else
            match_char?('>') ? op_token('|>') : op_token('|')
          end
        when '"'
          string_token(char)
        else
          number_token(char) ||
            identifier_token(char)
        end
      end

      def skip_whitespace(char)
        if char == "\n"
          @scanner.advance_line
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

      def identifier_token(char)
        if alpha_char?(char)
          while alpha_numeric?(@scanner.peek)
            @scanner.advance
          end

          text = @scanner.text(@start)

          if bool_token?(text)
            add_token(Token::Bool, text)
          elsif none_token?(text)
            add_token(Token::None, text)
          else
            if type = Keywords[text]
              add_token(type, text)
            else
              add_token(Token::Identifier, text)
            end
          end
        else
          @sink.add_error(:unexpected, char)
          add_token(Token::Illegal, "")
        end
      end

      def string_token(char)
        loop do
          break if @scanner.peek == '"'
          break if @scanner.at_end?

          if @scanner.peek == "\n"
            @scanner.advance_line
            @scanner.advance
            break
          end

          @scanner.advance
        end

        if @scanner.at_end?
          @sink.add_error(:unterminated)
          return add_token(Token::Illegal, "")
        end

        if @scanner.beginning_of_line?
          @sink.add_error(:unterminated)
          return add_token(Token::Illegal, "")
        end

        @scanner.advance

        text = @scanner.text(@start)
        add_token(Token::String, text)
      end

      def number_token(char)
        if digit_char?(char)
          token_type = Token::Int

          while digit_char?(@scanner.peek)
            @scanner.advance
          end

          if @scanner.peek == '.' && digit_char?(@scanner.peek_next)
            token_type = Token::Float
            @scanner.advance

            while digit_char?(@scanner.peek)
              @scanner.advance
            end
          end

          text = @scanner.text(@start)
          add_token(token_type, text)
        end
      end

      def_delegator :@scanner, :whitespace?
      def_delegator :@scanner, :alpha_numeric?
      def_delegator :@scanner, :alpha_char?
      def_delegator :@scanner, :digit_char?
      def_delegator :@scanner, :match_char?

      def add_token(type, lexeme = "")
        Token.new(
          type,
          lexeme,
          @start_pos.dup,
          @scanner.pos.dup
        ).tap { |token| @tokens << token }
      end

      def bool_token?(str)
        str == 'True' || str == 'False'
      end

      def none_token?(str)
        str == 'None'
      end

      def punc_token(str)
        add_token(punc_get(str), str)
      end

      def op_token(str)
        add_token(op_get(str), str)
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
