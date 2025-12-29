module Tao
  class Interpreter
    attr_reader :globals

    def initialize
      @globals = Environment.new
      @environment = @globals
    end

    def interpret(_statements)
    end
  end
end
