# frozen_string_literal: true
module Adventofcode2019
  Move = Ivo.new(:direction, :distance) do
    class << self
      def from_string(string)
        direction = string[0]
        distance = string[1..-1].to_i
        new(direction, distance)
      end
    end

    def points_from(point)
      points = []
      distance.times.each do
        point = case direction
        when 'U'
          point.move_up
        when 'D'
          point.move_down
        when 'R'
          point.move_right
        when 'L'
          point.move_left
        end
        points << point
      end
      points
    end
  end
end
