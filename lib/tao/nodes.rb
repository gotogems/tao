module Tao
  module Nodes
    class Node
      attr_reader :loc

      def accept(visitor)
        raise NotImplementedError
      end

      def children
        []
      end
    end

    class Program     < Node;      end
    class Statement   < Node;      end
    class Expression  < Node;      end
    class Declaration < Statement; end

    class BlockStatement < Statement
      def initialize(statements)
        @statements = statements
      end

      def accept(visitor)
        visitor.visit_block_statement(self)
      end

      def children
        @statements
      end
    end

    class AssignExpr < Expression
      attr_reader :target, :operator, :value

      def initialize(target, operator, value)
        @target   = target
        @operator = operator
        @value    = value
      end

      def accept(visitor)
        visitor.visit_assign_expr(self)
      end

      def children
        [@target, @value]
      end
    end

    class Identifier < Expression
      attr_reader :name

      def initialize(name)
        @name = name
      end

      def accept(visitor)
        visitor.visit_identifier(self)
      end
    end

    class BinaryExpr < Expression
      attr_reader :left, :operator, :right

      def initialize(left, operator, right)
        @left     = left
        @operator = operator
        @right    = right
      end

      def accept(visitor)
        visitor.visit_binary_expr(self)
      end

      def children
        [@left, @right]
      end
    end

    class UnaryExpr < Expression
      attr_reader :operator, :right

      def initialize(operator, right)
        @operator = operator
        @right    = right
      end

      def accept(visitor)
        visitor.visit_unary_expr(self)
      end

      def children
        [@right]
      end
    end

    class Literal < Expression
      attr_reader :type, :value

      def initialize(type, value)
        @type  = type
        @value = value
      end

      def accept(visitor)
        visitor.visit_literal(self)
      end
    end
  end
end
