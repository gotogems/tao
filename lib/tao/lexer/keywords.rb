module Tao
  module Lexer
    module Keywords
      RESERVED_WORDS = {
        'if'     => Token::If,
        'then'   => Token::Then,
        'else'   => Token::Else,
        'loop'   => Token::Loop,
        'is'     => Token::Is,
        'next'   => Token::Next,
        'leave'  => Token::Leave,
        'match'  => Token::Match,
        'return' => Token::Return,
        'fun'    => Token::Fun,
        'self'   => Token::Self,
        'let'    => Token::Let,
        'mut'    => Token::Mut,
        'use'    => Token::Use,
        'at'     => Token::At,
        'data'   => Token::Data,
        'and'    => Token::And,
        'or'     => Token::Or,
        'not'    => Token::Not
      }.freeze

      def self.[](str)
        RESERVED_WORDS[str]
      end
    end
  end
end
