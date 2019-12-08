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
        '1,0,0,0,99' => '2,0,0,0,99',
        '2,3,0,3,99' => '2,3,0,6,99',
        '2,4,4,5,99,0' => '2,4,4,5,99,9801',
        '1,1,1,4,99,5,6,0,99' => '30,1,1,4,2,5,6,0,99',
        '1002,4,3,4,33' => '1002,4,3,4,99',
      }.each do |program, expected|
        result = app.run_intcode_program(program: program)
        expect(result.to_s).to eq(expected)
      end
    end

    it "captures inputs and outputs" do
      outputs = []
      app.run_intcode_program(
        program: '3,0,4,0,99',
        on_input: -> { 123 },
        on_output: ->(output) { outputs << output }
      )
      expect(outputs).to eq([123])
    end

    it 'samples' do
      {
        '3,9,8,9,10,9,4,9,99,-1,8' => { 7 => 0, 8 => 1, 9 => 0 }, # equal-to-8 program (position mode)
        '3,9,7,9,10,9,4,9,99,-1,8' => { 6 => 1, 7 => 1, 8 => 0, 9 => 0 }, # less-than-8 program (position mode)
        '3,3,1108,-1,8,3,4,3,99' => { 7 => 0, 8 => 1, 9 => 0 }, # equal-to-8 program (immediate mode)
        '3,3,1107,-1,8,3,4,3,99' => { 6 => 1, 7 => 1, 8 => 0, 9 => 0 }, # less-than-8 program (immediate mode)
        '3,12,6,12,15,1,13,14,13,4,13,99,-1,0,1,9' => { 0 => 0, 1 => 1, 9 => 1 }, # 0 if 0, 1 otherwise (position mode)
        '3,3,1105,-1,9,1101,0,0,12,4,12,99,1' =>  { 0 => 0, 1 => 1, 9 => 1 }, # 0 if 0, 1 otherwise (immediate mode)
        "3,21,1008,21,8,20,1005,20,22,107,8,21,20,1006,20,31,
        1106,0,36,98,0,0,1002,21,125,20,4,20,1105,1,46,104,
        999,1105,1,46,1101,1000,1,20,4,20,1105,1,46,98,99" => { 6 => 999, 7 => 999, 8 => 1000, 9 => 1001, 10 => 1001 }
      }.each do |program, output_by_input|
        output_by_input.each do |input, output|
          outputs = []

          app.run_intcode_program(
            program: program,
            on_input: -> { input },
            on_output: ->(output) { outputs << output }
          )

          expect(outputs).to eq([output])
        end
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

  describe "#count_valid_passwords" do
    it "returns a count of the passwords that meet the password criteria in the given range" do
      expect(app.password_valid?(112233)).to eq(true)
      expect(app.password_valid?(123444)).to eq(false)
      expect(app.password_valid?(111122)).to eq(true)
    end
  end

  describe "#count_total_direct_and_indirect_orbits" do
    it "returns the total number of direct and indirect orbits in the given file" do
      result = app.count_total_direct_and_indirect_orbits(
        orbits_file_path: "#{files_dir}/sample_orbits_01.txt"
      )
      expect(result).to eq(42)

      result = app.count_total_direct_and_indirect_orbits(
        orbits_file_path: "#{files_dir}/sample_orbits_02.txt"
      )
      expect(result).to eq(42)
    end
  end
end
