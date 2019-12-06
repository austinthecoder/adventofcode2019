# frozen_string_literal: true
module Adventofcode2019
  IntcodeProgramState = Ivo.new(:codes, :opcode_position) do
    def next
      case opcode
      when 1, 2
        left_operand = codes[codes[opcode_position + 1]]
        right_operand = codes[codes[opcode_position + 2]]
        result_position = codes[opcode_position + 3]

        result = case opcode
        when 1
          left_operand + right_operand
        when 2
          left_operand * right_operand
        end

        next_codes = codes.merge(result_position => result)
        next_opcode_position = opcode_position + 4
      else
        raise("Unexpected opcode: #{opcode}")
      end

      self.class.new(next_codes, next_opcode_position)
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
      codes[opcode_position]
    end
  end
end
