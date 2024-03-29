lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "adventofcode2019/version"

Gem::Specification.new do |spec|
  spec.name = "adventofcode2019"
  spec.version = Adventofcode2019::VERSION
  spec.authors = ["Austin Schneider"]
  spec.email = ["me@austinschneider.com"]

  spec.summary = "Advent of Code 2019"
  spec.homepage = "https://github.com/austinthecoder/adventofcode2019"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/austinthecoder/adventofcode2019"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "rspec", "~> 3.9"

  spec.add_dependency "ivo", "~> 0.5"
  spec.add_dependency "icy", "~> 0.3"
end
