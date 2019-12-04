# frozen_string_literal: true
module Adventofcode2019
  IntcodeProgramState = Ivo.new(:codes, :opcode_position) do
    class << self
      def from_file(path)
        # from: 10,20,30
        #   to: { 0 => 10, 1 => 20, 2 => 30 }
        codes = File
          .read(path)
          .split(",")
          .each_with_index
          .reduce({}) { |result, (code, index)| result.merge(index => code.to_i) }

        new(codes, 0)
      end
    end

    def next
      return self if finished?

      result = left_operand.public_send(operator, right_operand)
      next_codes = codes.merge(result_position => result)
      self.class.new(next_codes, next_opcode_position)
    end

    def finished?
      opcode == 99
    end

    def to_s
      codes.values.join(",")
    end

    def code_at(position)
      codes[position]
    end

    private

    def opcode
      codes[opcode_position]
    end

    def next_opcode_position
      opcode_position + 4
    end

    def left_operand
      codes[codes[opcode_position + 1]]
    end

    def right_operand
      codes[codes[opcode_position + 2]]
    end

    def result_position
      codes[opcode_position + 3]
    end

    def operator
      case opcode
      when 1
        :+
      when 2
        :*
      else
        raise "Unexpected opcode: #{opcode}"
      end
    end
  end
end
