module Adventofcode2019
  Interface = Ivo.new(:bulk_fuel_calculator_v1, :bulk_fuel_calculator) do
    def calculate_total_fuel_required_v1(masses_file_path:)
      bulk_fuel_calculator_v1.calculate(masses_file_path: masses_file_path)
    end

    def calculate_total_fuel_required(masses_file_path:)
      bulk_fuel_calculator.calculate(masses_file_path: masses_file_path)
    end
  end
end
