module Tao
  class Interpreter
    attr_reader :globals

    def initialize
      @globals = Environment.new
      @environment = @globals
    end

    def interpret(_statements)
      evaluate(_statements)
    end

    def evaluate(expr)
      expr.accept(self)
    end
  end
end
