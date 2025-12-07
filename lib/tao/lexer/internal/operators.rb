module Tao
  module Lexer
    module Internal
      module Operators
        OPERATORS = {
          '+'   => Token::Plus,
          '-'   => Token::Minus,
          '*'   => Token::Star,
          '/'   => Token::Slash,
          '%'   => Token::Modulo,
          '>'   => Token::Greater,
          '<'   => Token::Less,
          '='   => Token::Equal,
          '!'   => Token::Bang,
          '&'   => Token::Illegal,
          '|'   => Token::Illegal,
          '?'   => Token::Illegal,
          '>='  => Token::GreaterEq,
          '<='  => Token::LessEq,
          '=='  => Token::EqualEq,
          '!='  => Token::BangEq,
          '&&'  => Token::And,
          '||'  => Token::Or,
          '|>'  => Token::PipeOp,
          '?.'  => Token::Illegal,
          '&&=' => Token::Illegal,
          '||=' => Token::Illegal
        }.freeze

        def self.[](str)
          OPERATORS[str]
        end
      end
    end
  end
end
