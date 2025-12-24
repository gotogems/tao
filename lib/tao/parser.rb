require 'tao/parse/precedence'
require 'tao/parse/rules'
require 'tao/parse_error'

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

    def parse_statement
      return parse_if     if match?(Token::If)
      return parse_loop   if match?(Token::Loop)
      return parse_leave  if match?(Token::Leave)
      return parse_match  if match?(Token::Match)
      return parse_return if match?(Token::Return)
      return parse_fun    if match?(Token::Fun)
      return parse_self   if match?(Token::Self)
      return parse_let    if match?(Token::Let)
      return parse_data   if match?(Token::Data)

      parse_expression
    end

    def parse_expression(rbp = Parse::PrecLowest)
      rule = Parse::Rules.of(peek)

      if rule.prefix.nil?
        raise ParseError
      end

      left = send(rule.prefix)

      while rbp < lbp_of(peek) do
        rule = Parse::Rules.of(peek)
        break if rule.infix.nil?

        left = send(rule.infix, left)
      end

      left
    end

    def parse_prefix
    end

    def parse_infix(left)
    end

    def parse_pipe(left)
    end

    def parse_grouping
    end

    def parse_identifier
      expr = Nodes::Identifier.new(peek.lexeme)
      advance
      expr
    end

    def parse_binary(left)
      operator = peek.type
      advance

      right = parse_expression(rbp_of(previous))
      Nodes::BinaryExpr.new(left, operator, right)
    end

    def parse_unary
      operator = peek.type
      advance

      right = parse_expression(Parse::PrecUnary)
      Nodes::UnaryExpr.new(operator, right)
    end

    def parse_literal
      expr = Nodes::Literal.new(peek.type, peek.value)
      advance
      expr
    end

    def precedence_of(token)
      Parse::Precedence.of(token)
    end

    alias_method :lbp_of, :precedence_of
    alias_method :rbp_of, :precedence_of

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

    def expect(type)
      consume(type, '')
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
