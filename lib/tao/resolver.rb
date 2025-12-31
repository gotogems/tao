module Tao
  class Resolver
    def initialize(interpreter)
      @interpreter = interpreter
    end

    def visit_block_statement(block)
      begin_scope
      resolve(block.statements)
      end_scope
      nil
    end

    def visit_binary_expr(expr)
      resolve(expr.left)
      resolve(expr.right)
      nil
    end

    def visit_unary_expr(expr)
      resolve(expr.right)
      nil
    end

    def visit_literal(_expr)
    end

    def begin_scope
      @scopes.push({})
    end

    def end_scope
      @scopes.pop
    end

    def resolve_statements(statements)
      statements.each do |statement|
        resolve_statement(statement)
      end
    end

    def resolve_statement(statement)
      statement.accept(self)
    end

    def resolve_local(expr, name)
      loop do
        i = @scopes.size - 1
        break if i < 0

        if @scopes[i].has_key?(name)
          @interpreter.resolve(expr, @scopes.size - 1 - i)
          return
        end

        i -= 1
      end
    end

    def resolve(expr)
      expr.accept(self)
    end
  end
end
