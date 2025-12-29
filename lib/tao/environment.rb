module Tao
  class Environment
    attr_reader :enclosing

    def initialize(enclosing = nil)
      @enclosing = enclosing
      @values = {}
    end
  end
end
