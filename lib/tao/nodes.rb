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

    class Binary < Expression
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

    class Unary < Expression
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
  end
end
