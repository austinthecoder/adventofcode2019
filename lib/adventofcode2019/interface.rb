# frozen_string_literal: true
module Adventofcode2019
  Interface = Ivo.new(
    :bulk_fuel_calculator_v1,
    :bulk_fuel_calculator,
    :origin,
    :password_validators_v1,
    :password_validators,
  ) do
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
      wires = File.readlines(wires_file_path).map { |line| Wire.from_string(line, origin) }

      intersecting_points = wires.map(&:points).reduce(:&).reject { |p| p == origin }

      intersecting_points.map { |p| p.distance_from(origin) }.min
    end

    def calculate_minimum_intersection_steps(wires_file_path:)
      wires = File.readlines(wires_file_path).map { |line| Wire.from_string(line, origin) }

      intersecting_points = wires.map(&:points).reduce(:&).reject { |p| p == origin }

      intersecting_points.map { |p| wires.sum { |w| w.points.index(p) } }.min
    end

    def password_valid_v1?(password)
      password = password.to_s
      password_validators_v1.all? { |v| v.valid?(password.to_s) }
    end

    def password_valid?(password)
      password = password.to_s
      password_validators.all? { |v| v.valid?(password.to_s) }
    end

    def count_valid_passwords_v1(range:)
      range.count { |number| password_valid_v1?(number) }
    end

    def count_valid_passwords(range:)
      range.count { |number| password_valid?(number) }
    end
  end
end
