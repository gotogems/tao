module Tao
  class Resolver
    def initialize(interpreter)
      @interpreter = interpreter
      @scopes      = []
    end

    def visit_block_statement(block)
      begin_scope
      block.statements.each(&:resolve_any)
      end_scope
    end

    def visit_binary_expr(expr)
      resolve(expr.left)
      resolve(expr.right)
    end

    def visit_unary_expr(expr)
      resolve(expr.right)
    end

    def visit_literal(_expr)
    end

    def declare(name)
      return if @scopes.empty?

      if @scopes.last.has_key?(name)
      else
        @scopes.last[name] = false
      end
    end

    def define(name)
      return if @scopes.empty?
      @scopes.last[name] = true
    end

    def resolve_local(expr, name)
      index = @scopes.size - 1
      depth = index

      loop do
        break if index < 0

        if @scopes[index].has_key?(name)
          @interpreter.resolve(expr, depth - index)
          return
        end

        index -= 1
      end
    end

    def resolve_any(statement)
      statement.accept(self)
    end

    def resolve(expr)
      expr.accept(self)
    end

    def begin_scope
      @scopes << {}
    end

    def end_scope
      @scopes.pop
    end
  end
end
