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

    def resolve(node)
      node.accept(self)
    end
  end
end
