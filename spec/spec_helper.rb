require "bundler/setup"
require "adventofcode2019"

module Helpers
  def files_dir
    @files_dir ||= "#{__dir__}/files"
  end

  def app
    @app ||= Adventofcode2019.start
  end
end

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.filter_run :focus
  config.run_all_when_everything_filtered = true

  config.include(Helpers)
end
