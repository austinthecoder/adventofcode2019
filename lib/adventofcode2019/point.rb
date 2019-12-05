# frozen_string_literal: true
module Adventofcode2019
  Point = Ivo.new(:x, :y) do
    def up
      self.class.new(x, y + 1)
    end

    def right
      self.class.new(x + 1, y)
    end

    def down
      self.class.new(x, y - 1)
    end

    def left
      self.class.new(x - 1, y)
    end

    def distance_from(point)
      (x - point.x).abs + (y - point.y).abs
    end
  end
end
