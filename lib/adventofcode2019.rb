require "adventofcode2019/version"

module Adventofcode2019
  class FuelCalculator
    def calculate(value)
      value = value.to_i

      fuel = (value / 3.0).floor - 2

      return 0 if fuel < 1

      fuel + calculate(fuel)
    end
  end

  extend self

  def calculate_total_fuel_required_v1(masses_file_path:)
    result = 0

    File.foreach(masses_file_path) do |line|
      line = line.strip
      next if line.empty?

      mass = line.to_i
      fuel_req = (mass / 3.0).floor - 2
      result += fuel_req
    end

    result
  end

  def calculate_total_fuel_required(masses_file_path:)
    fuel_calculator = FuelCalculator.new

    result = 0

    File.foreach(masses_file_path) do |line|
      line = line.strip
      next if line.empty?

      fuel = fuel_calculator.calculate(line)

      result += fuel
    end

    result
  end
end
