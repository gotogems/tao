module Tao
  module Parse
    PrecLowest   = -1
    PrecAssign   = 10
    PrecPipe     = 11
    PrecOr       = 20
    PrecAnd      = 21
    PrecEquality = 30
    PrecCompare  = 31
    PrecAdd      = 32
    PrecMul      = 33
    PrecUnary    = 40
    PrecCall     = 50

    module Precedence
      PRECEDENCE = {
        Token::Plus      => PrecAdd,
        Token::Minus     => PrecAdd,
        Token::Star      => PrecMul,
        Token::Slash     => PrecMul,
        Token::Modulo    => PrecMul,
        Token::Greater   => PrecCompare,
        Token::GreaterEq => PrecCompare,
        Token::Less      => PrecCompare,
        Token::LessEq    => PrecCompare,
        Token::Equal     => PrecAssign,
        Token::EqualEq   => PrecEquality,
        Token::BangEq    => PrecEquality,
        Token::And       => PrecAnd,
        Token::Or        => PrecOr,
        Token::PipeOp    => PrecPipe
      }.freeze

      def self.of(token)
        self[token.type] || PrecLowest
      end

      def self.[](type)
        PRECEDENCE[type]
      end
    end
  end
end
