module Tao
  class Interpreter
    attr_reader :globals

    def initialize
      @globals = Environment.new
      @environ = @globals
      @locals  = {}
    end

    def visit_binary_expr(expr)
      left = evaluate(expr.left)
      right = evaluate(expr.right)

      case expr.operator
      when Token::Plus   then left + right
      when Token::Minus  then left - right
      when Token::Star   then left * right
      when Token::Slash  then left / right
      when Token::Modulo then left % right
      else
      end
    end

    def visit_unary_expr(expr)
      right = evaluate(expr.right)

      case expr.operator
      when Token::Minus then -right
      else
      end
    end

    def visit_literal(expr)
      expr.value
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
