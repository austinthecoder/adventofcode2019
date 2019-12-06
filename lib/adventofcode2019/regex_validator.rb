# frozen_string_literal: true
module Adventofcode2019
  RegexValidator = Ivo.new(:regex) do
    def valid?(password)
      regex.match?(password.to_s)
    end
  end
end
