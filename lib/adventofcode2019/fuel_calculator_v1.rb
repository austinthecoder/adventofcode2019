# frozen_string_literal: true
module Adventofcode2019
  FuelCalculatorV1 = Ivo.new do
    def calculate(mass)
      (mass.to_i / 3.0).floor - 2
    end
  end
end
