RSpec.describe "app" do
  describe "#calculate_total_fuel_required_v1" do
    it "calculates the sum of the fuel requirements for all of the given masses" do
      result = app.calculate_total_fuel_required_v1(masses_file_path: "#{files_dir}/sample_masses.txt")
      expect(result).to eq(88_367)
    end
  end

  describe "#calculate_total_fuel_required" do
    it "calculates the sum of the fuel requirements for all of the given masses" do
      result = app.calculate_total_fuel_required(masses_file_path: "#{files_dir}/sample_masses.txt")
      expect(result).to eq(132_494)
    end
  end

  describe "#run_intcode_program" do
    it "runs the program returning the final state" do
      {
        '01' => '2,0,0,0,99',
        '02' => '2,3,0,6,99',
        '03' => '2,4,4,5,99,9801',
        '04' => '30,1,1,4,2,5,6,0,99',
      }.each do |suffix, expected|
        result = app.run_intcode_program(program_file_path: "#{files_dir}/sample_program_#{suffix}.txt")
        expect(result.to_s).to eq(expected)
        expect(result.finished?).to eq(true)
      end
    end
  end
end
