# frozen_string_literal: true
module Adventofcode2019
  IntcodeProgramState = Ivo.new(:codes, :instruction_pointer) do
    def next(on_input:, on_output:)
      case opcode
      when 1, 2
        result = case opcode
        when 1
          first_value + second_value
        when 2
          first_value * second_value
        end

        next_codes = codes.merge(third_parameter => result)
        next_instruction_pointer = instruction_pointer + 4
      when 3
        input = if on_input
          on_input.()
        else
          print 'input: '
          gets
        end

        input = input.to_i

        next_codes = codes.merge(first_parameter => input)
        next_instruction_pointer = instruction_pointer + 2
      when 4
        if on_output
          on_output.(first_value)
        else
          puts "output: #{first_value}"
        end

        next_codes = codes
        next_instruction_pointer = instruction_pointer + 2
      when 5
        next_codes = codes
        next_instruction_pointer = first_value != 0 ? second_value : instruction_pointer + 3
      when 6
        next_codes = codes
        next_instruction_pointer = first_value == 0 ? second_value : instruction_pointer + 3
      when 7
        value = first_value < second_value ? 1 : 0

        next_codes = codes.merge(third_parameter => value)
        next_instruction_pointer = instruction_pointer + 4
      when 8
        value = first_value == second_value ? 1 : 0

        next_codes = codes.merge(third_parameter => value)
        next_instruction_pointer = instruction_pointer + 4
      else
        raise("Unexpected opcode: #{opcode}")
      end

      self.class.new(next_codes, next_instruction_pointer)
    end

    def finished?
      opcode == 99
    end

    def to_s
      codes.values.join(",")
    end

    def [](index)
      codes[index]
    end

    private

    def opcode
      codes[instruction_pointer] % 100
    end

    def first_parameter
      codes[instruction_pointer + 1]
    end

    def second_parameter
      codes[instruction_pointer + 2]
    end

    def third_parameter
      codes[instruction_pointer + 3]
    end

    def first_value
      first_parameter_mode = (codes[instruction_pointer] / 100) % 10

      case first_parameter_mode
      when 0
        codes[first_parameter]
      when 1
        first_parameter
      end
    end

    def second_value
      second_parameter_mode = (codes[instruction_pointer] / 1_000) % 10

      case second_parameter_mode
      when 0
        codes[second_parameter]
      when 1
        second_parameter
      end
    end
  end
end
