# frozen_string_literal: true
module Adventofcode2019
  MassStreamer = Ivo.new do
    def stream(file_path:)
      File.foreach(file_path) do |line|
        yield line.to_i
      end
    end
  end
end
