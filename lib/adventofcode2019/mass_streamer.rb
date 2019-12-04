module Adventofcode2019
  class MassStreamer
    def stream(file_path:)
      File.foreach(file_path) do |line|
        line = line.strip
        next if line.empty?

        yield line.to_i
      end
    end
  end
end
