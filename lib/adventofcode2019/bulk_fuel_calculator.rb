# frozen_string_literal: true
module Adventofcode2019
  BulkFuelCalculator = Ivo.new(:fuel_calculator) do
    def calculate(masses_file_path:)
      File.foreach(masses_file_path).sum do |line|
        fuel_calculator.calculate(line.to_i)
      end
    end
  end
end
