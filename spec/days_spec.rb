RSpec.describe "days" do
  context "day 1" do
    context "part 1" do
      it "3477353" do
        answer = app.calculate_total_fuel_required_v1(masses_file_path: "#{files_dir}/day_01_masses.txt")
        expect(answer).to eq(3477353)
      end
    end

    context "part 2" do
      it "5213146" do
        answer = app.calculate_total_fuel_required(masses_file_path: "#{files_dir}/day_01_masses.txt")
        expect(answer).to eq(5213146)
      end
    end
  end

  context "day 2" do
    it "10566835" do
      result = app.run_intcode_program(program_file_path: "#{files_dir}/day_02_program_fixed.txt")
      expect(result.code_at(0)).to eq(10566835)
    end
  end
end
