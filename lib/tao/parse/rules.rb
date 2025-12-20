module Tao
  module Parse
    Rule = Struct.new(:prefix, :infix)

    module Rules
      RULES = {
        Token::Plus       => Rule.new(infix:        :parse_infix),
        Token::Minus      => Rule.new(:parse_unary, :parse_infix),
        Token::Star       => Rule.new(infix:        :parse_infix),
        Token::Slash      => Rule.new(infix:        :parse_infix),
        Token::Modulo     => Rule.new(infix:        :parse_infix),
        Token::Greater    => Rule.new(infix:        :parse_infix),
        Token::GreaterEq  => Rule.new(infix:        :parse_infix),
        Token::Less       => Rule.new(infix:        :parse_infix),
        Token::LessEq     => Rule.new(infix:        :parse_infix),
        Token::Equal      => Rule.new(infix:        :parse_infix),
        Token::EqualEq    => Rule.new(infix:        :parse_infix),
        Token::BangEq     => Rule.new(infix:        :parse_infix),
        Token::And        => Rule.new(infix:        :parse_infix),
        Token::Or         => Rule.new(infix:        :parse_infix),
        Token::Not        => Rule.new(:parse_unary),
        Token::PipeOp     => Rule.new(infix:        :parse_infix),
        Token::Dot        => Rule.new(infix:        :parse_infix),
        Token::LSquare    => Rule.new(:parse_array, :parse_index),
        Token::LBrace     => Rule.new(:parse_prefix),
        Token::LParen     => Rule.new(:parse_group, :parse_call),
        Token::Identifier => Rule.new(:parse_identifier),
        Token::String     => Rule.new(:parse_literal),
        Token::Int        => Rule.new(:parse_literal),
        Token::Float      => Rule.new(:parse_literal),
        Token::Bool       => Rule.new(:parse_literal),
        Token::None       => Rule.new(:parse_literal),
        Token::If         => Rule.new(:parse_if),
        Token::Match      => Rule.new(:parse_match),
        Token::Fun        => Rule.new(:parse_func),
        Token::Self       => Rule.new(:parse_self)
      }.freeze

      def self.of(token)
        self[token.type] || Rule.new
      end

      def self.[](type)
        RULES[type]
      end
    end
  end
end
