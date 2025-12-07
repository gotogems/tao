require 'tao/token/types'
require 'tao/token/span'

module Tao
  class Token
    include Types
    attr_reader :type, :lexeme, :span

    def initialize(type, lexeme, *args)
      @span = Span.new(*args)
      @lexeme = lexeme
      @type = type
    end

    def literal
      @_literal ||= proc {
        case @type
        when Token::Int    then @lexeme.to_i
        when Token::Float  then @lexeme.to_f
        when Token::String then parse_string @lexeme
        when Token::Bool   then parse_bool   @lexeme
        when Token::None   then nil
        else
        end
      }.()
    end

    alias_method :value, :literal

    def parse_string(str)
      str[1, str.length - 2]
    end

    def parse_bool(str)
      str.start_with?('T')
    end
  end
end
