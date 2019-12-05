# frozen_string_literal: true
module Adventofcode2019
  Move = Ivo.new do
    Up = Ivo.new(:distance) do
      def points_from(point)
        distance.times.map { point = point.up }
      end
    end

    Right = Ivo.new(:distance) do
      def points_from(point)
        distance.times.map { point = point.right }
      end
    end

    Down = Ivo.new(:distance) do
      def points_from(point)
        distance.times.map { point = point.down }
      end
    end

    Left = Ivo.new(:distance) do
      def points_from(point)
        distance.times.map { point = point.left }
      end
    end

    class << self
      def from_string(string)
        direction = string[0]
        distance = string[1..-1].to_i

        case direction
        when 'U'
          Up.new(distance)
        when 'R'
          Right.new(distance)
        when 'D'
          Down.new(distance)
        when 'L'
          Left.new(distance)
        end
      end
    end
  end
end
