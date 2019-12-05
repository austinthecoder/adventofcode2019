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

  describe "#calculate_distance_to_closest_intersection" do
    it "returns the Manhattan distance from the central port to the closest intersection" do
      {
        '01' => 159,
        '02' => 135,
      }.each do |suffix, expected|
        wires_file_path = "#{files_dir}/sample_wires_#{suffix}.txt"
        result = app.calculate_distance_to_closest_intersection(wires_file_path: wires_file_path)
        expect(result).to eq(expected)
      end
    end
  end

  describe "#calculate_minimum_intersection_steps" do
    it "returns the fewest combined steps the wires must take to reach an intersection" do
      {
        '01' => 610,
        '02' => 410,
      }.each do |suffix, expected|
        wires_file_path = "#{files_dir}/sample_wires_#{suffix}.txt"
        result = app.calculate_minimum_intersection_steps(wires_file_path: wires_file_path)
        expect(result).to eq(expected)
      end
    end
  end

  describe "#password_valid_v1?" do
    it "returns a count of the passwords that meet the password criteria in the given range" do
      expect(app.password_valid_v1?(111111)).to eq(true)
      expect(app.password_valid_v1?(223450)).to eq(false)
      expect(app.password_valid_v1?(123789)).to eq(false)
    end
  end
end
