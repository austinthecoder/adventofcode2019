module Adventofcode2019
  FuelCalculator = Ivo.new(:fuel_calculator) do
    def calculate(value)
      fuel = fuel_calculator.calculate(value)

      return 0 if fuel < 1

      fuel + calculate(fuel)
    end
  end
end
