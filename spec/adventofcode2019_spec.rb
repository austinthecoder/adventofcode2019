RSpec.describe Adventofcode2019 do
  describe ".calculate_total_fuel_required_v1" do
    it "calculates the sum of the fuel requirements for all of the given masses" do
      result = Adventofcode2019.calculate_total_fuel_required_v1(masses_file_path: "#{__dir__}/sample_masses.txt")
      expect(result).to eq(88_367)
    end
  end

  describe ".calculate_total_fuel_required" do
    it "calculates the sum of the fuel requirements for all of the given masses" do
      result = Adventofcode2019.calculate_total_fuel_required(masses_file_path: "#{__dir__}/sample_masses.txt")
      expect(result).to eq(132_494)
    end
  end
end
