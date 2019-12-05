# frozen_string_literal: true
module Adventofcode2019
  Wire = Ivo.new(:points) do
    class << self
      def from_string(string, origin)
        moves = string.strip.split(',').map { |move| Move.from_string(move) }

        points = moves.reduce([origin]) do |result, move|
          result + move.points_from(result[-1])
        end

        new(points.uniq)
      end
    end
  end
end
