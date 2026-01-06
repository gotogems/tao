module Tao
  module Parse
    class Return < RuntimeError
      attr_reader :value

      def initialize(value = nil)
        @value = value
        super
      end
    end
  end
end
