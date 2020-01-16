require_relative 'lib/refactoring_a_test/version'

Gem::Specification.new do |spec|
  spec.name          = "refactoring_a_test"
  spec.version       = RefactoringATest::VERSION
  spec.authors       = ["Arturo Pie"]
  spec.email         = ["arturop@nulogy.com"]

  spec.summary       = "This is a ruby version of the example test in xUnit Test Patterns: Refactoring a Test"
  spec.homepage      = "https://github.com/arturopie/refactoring_a_test"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/arturopie/refactoring_a_test"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
end
