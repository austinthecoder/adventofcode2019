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
    context "part 1" do
      it "10566835" do
        result = app.run_intcode_program(
          program_file_path: "#{files_dir}/day_02_program.txt",
          noun: 12,
          verb: 2,
        )
        expect(result.split(',')[0]).to eq('10566835')
      end
    end

    context "part 2" do
      it "2347" do
        result = app.run_intcode_program(
          program_file_path: "#{files_dir}/day_02_program.txt",
          noun: 23,
          verb: 47,
        )
        expect(result.split(',')[0]).to eq('19690720')
      end
    end
  end

  context "day 3" do
    context "part 1" do
      it "768" do
        result = app.calculate_distance_to_closest_intersection(wires_file_path: "#{files_dir}/day_03_wires.txt")
        expect(result).to eq(768)
      end
    end

    context "part 2" do
      it "8684" do
        result = app.calculate_minimum_intersection_steps(wires_file_path: "#{files_dir}/day_03_wires.txt")
        expect(result).to eq(8684)
      end
    end
  end

  context "day 4" do
    context "part 1" do
      it "945" do
        result = app.count_valid_passwords_v1(range: 264360..746325)
        expect(result).to eq(945)
      end
    end

    context "part 2" do
      it "617" do
        result = app.count_valid_passwords(range: 264360..746325)
        expect(result).to eq(617)
      end
    end
  end

  context "day 5" do
    context "part 1" do
      it "13547311" do
        outputs = []

        app.run_intcode_program(
          program_file_path: "#{files_dir}/day_05_program.txt",
          on_input: -> { 1 },
          on_output: ->(output) { outputs << output },
        )

        expect(outputs).to eq([0, 0, 0, 0, 0, 0, 0, 0, 0, 13547311])
      end
    end

    context "part 2" do
      it "236453" do
        outputs = []

        app.run_intcode_program(
          program_file_path: "#{files_dir}/day_05_program.txt",
          on_input: -> { 5 },
          on_output: ->(output) { outputs << output },
        )

        expect(outputs).to eq([236453])
      end
    end
  end

  context "day 6" do
    context "part 1" do
      it "295936" do
        result = app.count_total_direct_and_indirect_orbits(
          orbits_file_path: "#{files_dir}/day_06_orbits.txt"
        )
        expect(result).to eq(295_936)
      end
    end
  end
end
