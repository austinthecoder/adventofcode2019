# frozen_string_literal: true
require 'icy'
require 'ivo'
require 'forwardable'

module Adventofcode2019
  extend Forwardable
  extend self

  def start
    mass_streamer = MassStreamer.new
    fuel_calculator_v1 = FuelCalculatorV1.new
    bulk_fuel_calculator_v1 = BulkFuelCalculator.with(
      mass_streamer: mass_streamer,
      fuel_calculator: fuel_calculator_v1,
    )
    bulk_fuel_calculator = BulkFuelCalculator.with(
      mass_streamer: mass_streamer,
      fuel_calculator: FuelCalculator.new(fuel_calculator_v1),
    )

    Interface.with(
      bulk_fuel_calculator_v1: bulk_fuel_calculator_v1,
      bulk_fuel_calculator: bulk_fuel_calculator,
    )
  end

  def_delegators(
    :start,
    :calculate_total_fuel_required_v1,
    :calculate_total_fuel_required,
  )
end

Icy.require_tree('adventofcode2019')
