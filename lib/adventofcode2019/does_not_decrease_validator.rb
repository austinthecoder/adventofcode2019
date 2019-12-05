# frozen_string_literal: true
module Adventofcode2019
  DoesNotDecreaseValidator = Ivo.new do
    def valid?(password)
      digits = password.to_s.split('').map(&:to_i)
      !digits[1..-1].each_with_index.any? { |digit, index| digit < digits[index] }
    end
  end
end
