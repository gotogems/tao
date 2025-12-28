module Tao
  module Lexer
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

      def self.get(str)
        PUNCTUATION[str]
      end
    end
  end
end
