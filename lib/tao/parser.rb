module Tao
  class Parser
    def initialize(lexer)
      @lexer   = lexer
      @tokens  = []
      @current = 0
    end

    def advance
      @current += 1 unless eof?
      previous
    end

    def peek
      @tokens[@current]
    end

    def previous
      @tokens[@current.pred]
    end

    def eof?
      peek.eof?
    end
  end
end
