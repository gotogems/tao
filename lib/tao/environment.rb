module Tao
  class Environment
    attr_reader :enclosing

    def initialize(enclosing = nil)
      @enclosing = enclosing
      @values = {}
    end

    def ancestor(distance)
      environ = self

      loop do
        break if distance < 1
        environ = environ.enclosing
        distance -= 1
      end

      environ
    end

    def define(name, value)
      @values[name] = value
    end

    def assign_at(distance, name, value)
      ancestor(distance).assign(name, value)
    end

    def assign(name, value)
      if values.has_key?(name)
        values[name] = value
      elsif enclosing
        enclosing.assign(name, value)
      else
        raise RuntimeError
      end
    end

    def get_at(distance, name)
      ancestor(distance).get(name)
    end

    def get(name)
      return values[name]        if values.has_key?(name)
      return enclosing.get(name) if enclosing
      raise RuntimeError
    end
  end
end
