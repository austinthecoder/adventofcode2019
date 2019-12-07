# frozen_string_literal: true
module Adventofcode2019
  IntcodeProgramState = Ivo.new(:codes, :instruction_pointer) do
    def next(on_input:, on_output:)
      first_parameter_mode = (codes[instruction_pointer] / 100) % 10
      second_parameter_mode = (codes[instruction_pointer] / 1_000) % 10

      case opcode
      when 1, 2
        first_parameter = codes[instruction_pointer + 1]
        first_value = case first_parameter_mode
        when 0
          codes[first_parameter]
        when 1
          first_parameter
        end

        second_parameter = codes[instruction_pointer + 2]
        second_value = case second_parameter_mode
        when 0
          codes[second_parameter]
        when 1
          second_parameter
        end

        result_position = codes[instruction_pointer + 3]

        result = case opcode
        when 1
          first_value + second_value
        when 2
          first_value * second_value
        end

        next_codes = codes.merge(result_position => result)
        instruction_size = 4
      when 3
        result_position = codes[instruction_pointer + 1]

        input = if on_input
          on_input.()
        else
          print 'input: '
          gets
        end

        input = input.to_i

        next_codes = codes.merge(result_position => input)
        instruction_size = 2
      when 4
        output = case first_parameter_mode
        when 0
          codes[codes[instruction_pointer + 1]]
        when 1
          codes[instruction_pointer + 1]
        end

        if on_output
          on_output.(output)
        else
          puts "output: #{output}"
        end

        next_codes = codes
        instruction_size = 2
      else
        raise("Unexpected opcode: #{opcode}")
      end

      self.class.new(next_codes, instruction_pointer + instruction_size)
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
  end
end
