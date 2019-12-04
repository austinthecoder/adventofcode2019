RSpec.describe "days" do
  context "day 1" do
    it "part 1 = 3477353" do
      answer = app.calculate_total_fuel_required_v1(masses_file_path: "#{files_dir}/day_01_masses.txt")
      expect(answer).to eq(3477353)
    end

    it "part 2 = 5213146" do
      answer = app.calculate_total_fuel_required(masses_file_path: "#{files_dir}/day_01_masses.txt")
      expect(answer).to eq(5213146)
    end
  end
end
