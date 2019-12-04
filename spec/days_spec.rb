RSpec.describe "Days" do
  context "day 1" do
    it "part 1" do
      answer = Adventofcode2019.calculate_total_fuel_required(masses_file_path: "#{__dir__}/day_01_masses.txt")
      expect(answer).to eq(3477353)
    end
  end
end
