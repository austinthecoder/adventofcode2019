# frozen_string_literal: true
module Adventofcode2019
  Interface = Ivo.new(:bulk_fuel_calculator_v1, :bulk_fuel_calculator) do
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
  end
end
