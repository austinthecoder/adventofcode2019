require "adventofcode2019/version"

module Adventofcode2019
  extend self

  def calculate_total_fuel_required(masses_file_path:)
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
end
