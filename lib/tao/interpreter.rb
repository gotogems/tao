module Tao
  class Interpreter
    attr_reader :globals

    def initialize
      @globals = Environment.new
      @environ = @globals
      @locals  = {}
    end

    def interpret(statements)
      begin
        statements.each do |statement|
          execute(statement)
        end
      rescue RuntimeError => error
      end
    end

    def resolve(expr, depth)
      @locals[expr] = depth
    end

    def execute(statement)
      statement.accept(self)
    end

    def evaluate(expr)
      expr.accept(self)
    end
  end
end
