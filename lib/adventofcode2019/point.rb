# frozen_string_literal: true
module Adventofcode2019
  Point = Ivo.new(:x, :y) do
    def move_up
      self.class.new(x, y + 1)
    end

    def move_right
      self.class.new(x + 1, y)
    end

    def move_down
      self.class.new(x, y - 1)
    end

    def move_left
      self.class.new(x - 1, y)
    end

    def distance
      x.abs + y.abs
    end
  end
end
