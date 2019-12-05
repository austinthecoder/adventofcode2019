# frozen_string_literal: true
module Adventofcode2019
  Wire = Ivo.new(:points) do
    class << self
      def from_string(string)
        moves = string.strip.split(',').map { |move| Move.from_string(move) }

        current_point = Point.new(0, 0)

        points = moves.reduce([]) do |result, move|
          sub_points = move.points_from(current_point)
          current_point = sub_points[-1]
          result + sub_points
        end

        new(points.uniq)
      end
    end
  end
end
