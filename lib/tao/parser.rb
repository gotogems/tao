module Tao
  class Parser
    extend Forwardable

    def initialize(lexer)
      @lexer   = lexer
      @current = 0
      init_tokens
    end

    def init_tokens
      next_token
      next_token
    end

    def parse_program
      begin
        parse_expression
      rescue ParseError
        synchronize
      end
    end

    def parse_expression(precedence = 0)
      if prefix_fn = prefix_rule_of(peek)
        left = send(prefix_fn)

        loop do
          break if precedence >= precedence_of(peek)
          infix_fn = infix_rule_of(peek)

          break if infix_fn.nil?
          advance

          left = send(infix_fn)
        end

        left
      else
        raise ParseError
      end
    end

    def parse_prefix
    end

    def parse_infix(left)
    end

    def_delegator :@lexer, :next_token
    def_delegator :@lexer, :tokens

    def synchronize
      advance

      loop do
        break if eof?
        return if previous.type == Token::Semi

        case peek.type
        when Token::If     then return
        when Token::Loop   then return
        when Token::Match  then return
        when Token::Return then return
        when Token::Fun    then return
        when Token::Let    then return
        when Token::Data   then return
        else
          advance
        end
      end
    end

    def consume(type, message)
      return advance if check?(type)
      raise ParseError
    end

    def match?(*types)
      types.each do |type|
        if check?(type)
          advance
          return true
        end
      end

      false
    end

    def check?(type)
      return false if eof?
      peek.type == type
    end

    def advance
      @_peek_token = next_token
      @current += 1 unless eof?
      previous
    end

    def previous
      tokens[@current.pred]
    end

    def peek
      tokens[@current]
    end

    def eof?
      peek.eof?
    end
  end
end
