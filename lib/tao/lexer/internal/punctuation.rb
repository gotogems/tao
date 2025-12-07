module Tao
  module Lexer
    module Internal
      module Punctuation
        PUNCTUATION = {
          '{' => Token::LBrace,
          '}' => Token::RBrace,
          '[' => Token::LSquare,
          ']' => Token::RSquare,
          '(' => Token::LParen,
          ')' => Token::RParen,
          ',' => Token::Comma,
          ':' => Token::Colon,
          ';' => Token::Semi,
          '.' => Token::Dot
        }.freeze

        def self.[](str)
          PUNCTUATION[str]
        end
      end
    end
  end
end
