# frozen_string_literal: true
require 'icy'
require 'ivo'

module Adventofcode2019
  extend self

  def start
    fuel_calculator_v1 = FuelCalculatorV1.new
    bulk_fuel_calculator_v1 = BulkFuelCalculator.with(fuel_calculator: fuel_calculator_v1)
    bulk_fuel_calculator = BulkFuelCalculator.with(fuel_calculator: FuelCalculator.new(fuel_calculator_v1))
    does_not_decrease_validator = DoesNotDecreaseValidator.new

    Interface.with(
      bulk_fuel_calculator_v1: bulk_fuel_calculator_v1,
      bulk_fuel_calculator: bulk_fuel_calculator,
      origin: Point.new(0, 0),
      password_validators_v1: [
        does_not_decrease_validator,
        RegexValidator.new(/(\d)\1+/)
      ],
      password_validators: [
        does_not_decrease_validator,
        RegexValidator.new(/(?:^|(.)(?!\1))(\d)\2(?!\2)/),
      ],
    )
  end
end

Icy.require_tree('adventofcode2019')
