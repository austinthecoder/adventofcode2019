# frozen_string_literal: true
module Adventofcode2019
  Interface = Ivo.new(:bulk_fuel_calculator_v1, :bulk_fuel_calculator, :origin) do
    def calculate_total_fuel_required_v1(masses_file_path:)
      bulk_fuel_calculator_v1.calculate(masses_file_path: masses_file_path)
    end

    def calculate_total_fuel_required(masses_file_path:)
      bulk_fuel_calculator.calculate(masses_file_path: masses_file_path)
    end

    def run_intcode_program(program_file_path:, noun: nil, verb: nil)
      # from: 10,20,30
      #   to: { 0 => 10, 1 => 20, 2 => 30 }
      codes = File
        .read(program_file_path)
        .split(",")
        .each_with_index
        .reduce({}) { |result, (code, index)| result.merge(index => code.to_i) }

      codes = codes.merge(1 => noun) if noun
      codes = codes.merge(2 => verb) if verb

      state = IntcodeProgramState.with(codes: codes, opcode_position: 0)
      state = state.next while !state.finished?
      state
    end

    def calculate_distance_to_closest_intersection(wires_file_path:)
      points_builder = ->(line) do
        moves = line.strip.split(',').map { |move| Move.from_string(move) }

        points = moves.reduce([origin]) do |result, move|
          result + move.points_from(result[-1])
        end

        points.uniq
      end

      points1, points2 = File.readlines(wires_file_path).map(&points_builder)

      intersecting_points = (points1 & points2).reject { |point| point == origin }

      intersecting_points.map { |point| point.distance_from(origin) }.min
    end

    def calculate_minimum_intersection_steps(wires_file_path:)
      points_builder = ->(line) do
        moves = line.strip.split(',').map { |move| Move.from_string(move) }

        points = moves.reduce([origin]) do |result, move|
          result + move.points_from(result[-1])
        end

        points.uniq
      end

      points1, points2 = File.readlines(wires_file_path).map(&points_builder)

      intersecting_points = (points1 & points2).reject { |point| point == origin }

      intersecting_points.map { |point| points1.index(point) + points2.index(point) }.min
    end
  end
end
