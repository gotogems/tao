module Tao
  class Token
    module Types
      def self.included(base)
        token_type :Plus, :Minus, :Star, :Slash, :Modulo,
                   :Greater, :GreaterEq, :Less, :LessEq,
                   :Equal, :EqualEq, :Bang, :BangEq,
                   :And, :Or, :Not, :Pipe

        token_type :Comma, :Colon, :Semi, :Dot,
                   :LSquare, :RSquare,
                   :LBrace, :RBrace,
                   :LParen, :RParen

        token_type :Identifier, :String, :Int,
                   :Float, :Bool, :None,
                   :EOF, :Illegal

        token_type :If, :Then, :Else, :Loop,
                   :Is,
                   :Next, :Leave,
                   :Match, :Return,
                   :Fun, :Self,
                   :Let, :Mut,
                   :Use, :At,
                   :Data
      end

      def self.token_type(*types)
        types.each { const_set _1, _1 }
      end
    end
  end
end
