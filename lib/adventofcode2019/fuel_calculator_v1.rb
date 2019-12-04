module Adventofcode2019
  class FuelCalculatorV1
    def calculate(mass)
      (mass.to_i / 3.0).floor - 2
    end
  end
end
