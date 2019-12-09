# frozen_string_literal: true
module Adventofcode2019
  OrbitMap = Ivo.new(:data) do
    extend Forwardable

    class << self
      def build(objects, orbits)
        data = objects.reduce({}) do |result, object|
          orbiters = orbits
            .select { |orbitee, _| orbitee == object }
            .map { |_, orbiter| orbiter }

          result.merge(object => build(orbiters, orbits))
        end

        new(data)
      end
    end

    def_delegators(:data, :[])

    def total_direct_and_indirect_orbits
      size + data.sum { |_, orbit_map| orbit_map.total_direct_and_indirect_orbits }
    end

    def size
      data.sum { |_, orbit_map| 1 + orbit_map.size }
    end
  end
end
