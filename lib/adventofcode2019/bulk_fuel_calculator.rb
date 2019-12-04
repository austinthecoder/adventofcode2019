# frozen_string_literal: true
module Adventofcode2019
  BulkFuelCalculator = Ivo.new(:mass_streamer, :fuel_calculator) do
    def calculate(masses_file_path:)
      result = 0

      mass_streamer.stream(file_path: masses_file_path) do |mass|
        result += fuel_calculator.calculate(mass)
      end

      result
    end
  end
end
