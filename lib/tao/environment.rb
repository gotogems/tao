module Tao
  class Environment
    extend Forwardable
    attr_reader :enclosing

    def initialize(enclosing = nil)
      @enclosing = enclosing
      @values    = {}
    end

    def assign_at(distance, name, value)
      ancestor(distance).assign(name, value)
    end

    def get_at(distance, name)
      ancestor(distance).get(name)
    end

    def ancestor(distance = 1)
      environ = self
      distance.times { environ = environ.enclosing }
      environ
    end

    def assign(name, value)
      return store(name, value)            if has_key?(name)
      return enclosing.assign(name, value) if enclosing
      raise RuntimeError
    end

    def get(name)
      return @values[name]       if has_key?(name)
      return enclosing.get(name) if enclosing
      raise RuntimeError
    end

    def_delegator :@values, :has_key?
    def_delegator :@values, :store

    def define(name, value)
      store(name, value)
    end
  end
end
