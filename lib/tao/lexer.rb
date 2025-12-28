require 'tao/lexer/errorhandler'
require 'tao/lexer/tokenizer'

module Tao
  module Lexer
    UnterminatedString = Data.define(:pos)
    UnexpectedChar     = Data.define(:pos, :char)
    IllegalToken       = Data.define(:pos, :lexeme)

    def self.tokenize(source)
      tokenizer = Tokenizer.new(source)
    end
  end
end
