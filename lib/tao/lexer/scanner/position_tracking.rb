module Tao
  module Lexer
    class Scanner
      module PositionTracking
        def self.included(base)
          base.class_eval { attr_reader :pos }
        end

        def init_pos
          @pos = Position.new(0, 1, 1)
        end

        def beginning_of_line?
          @pos.col == 1
        end
      end
    end
  end
end
