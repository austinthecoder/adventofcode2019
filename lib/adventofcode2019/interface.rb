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

    def run_intcode_program(
      program: nil,
      program_file_path: nil,
      noun: nil,
      verb: nil,
      on_input: nil,
      on_output: nil
    )
      program ||= File.read(program_file_path)

      # from: 10,20,30
      #   to: { 0 => 10, 1 => 20, 2 => 30 }
      codes = program
        .split(",")
        .each_with_index
        .reduce({}) { |result, (code, index)| result.merge(index => code.to_i) }

      codes = codes.merge(1 => noun) if noun
      codes = codes.merge(2 => verb) if verb

      instruction_pointer = 0

      loop do
        opcode = codes[instruction_pointer] % 100

        break if opcode == 99

        first_parameter_mode = (codes[instruction_pointer] / 100) % 10
        second_parameter_mode = (codes[instruction_pointer] / 1_000) % 10

        first_parameter = codes[instruction_pointer + 1]
        second_parameter = codes[instruction_pointer + 2]
        third_parameter = codes[instruction_pointer + 3]

        first_value = case first_parameter_mode
        when 0
          codes[first_parameter]
        when 1
          first_parameter
        end

        second_value = case second_parameter_mode
        when 0
          codes[second_parameter]
        when 1
          second_parameter
        end

        case opcode
        when 1, 2
          result = case opcode
          when 1
            first_value + second_value
          when 2
            first_value * second_value
          end

          codes = codes.merge(third_parameter => result)
          instruction_pointer = instruction_pointer + 4
        when 3
          input = if on_input
            on_input.()
          else
            print 'input: '
            gets
          end

          input = input.to_i

          codes = codes.merge(first_parameter => input)
          instruction_pointer = instruction_pointer + 2
        when 4
          if on_output
            on_output.(first_value)
          else
            puts "output: #{first_value}"
          end

          codes = codes
          instruction_pointer = instruction_pointer + 2
        when 5
          codes = codes
          instruction_pointer = first_value != 0 ? second_value : instruction_pointer + 3
        when 6
          codes = codes
          instruction_pointer = first_value == 0 ? second_value : instruction_pointer + 3
        when 7
          value = first_value < second_value ? 1 : 0

          codes = codes.merge(third_parameter => value)
          instruction_pointer = instruction_pointer + 4
        when 8
          value = first_value == second_value ? 1 : 0

          codes = codes.merge(third_parameter => value)
          instruction_pointer = instruction_pointer + 4
        else
          raise("Unexpected opcode: #{opcode}")
        end
      end

      codes.values.join(',')
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

    def count_total_direct_and_indirect_orbits(orbits_file_path:)
      orbits = File.readlines(orbits_file_path).map { |line| line.strip.split(")") }

      orbit_map = OrbitMap.build(['COM'], orbits)

      orbit_map['COM'].total_direct_and_indirect_orbits
    end
  end
end
