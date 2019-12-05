# frozen_string_literal: true
module Adventofcode2019
  RegexValidator = Ivo.new(:regex) do
    def valid?(password)
      password.to_s.match?(regex)
    end
  end
end
