# frozen_string_literal: true
module Adventofcode2019
  IntcodeProgramState = Ivo.new(:codes, :opcode_position) do
    def next
      self.class.new(next_codes, opcode_position + 4)
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

    def next_codes
      result_position = codes[opcode_position + 3]
      codes.merge(result_position => calculate_result)
    end

    def opcode
      codes[opcode_position]
    end

    def calculate_result
      left_operand = codes[codes[opcode_position + 1]]
      right_operand = codes[codes[opcode_position + 2]]

      case opcode
      when 1
        left_operand + right_operand
      when 2
        left_operand * right_operand
      end
    end
  end
end
