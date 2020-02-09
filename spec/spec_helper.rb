require "bundler/setup"
require "refactoring_a_test"
require "factory_bot"

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.before(:suite) do
    FactoryBot.find_definitions
  end

  config.after do
    expect(DB.instance.all).to be_empty, "The test fixture was not properly cleaned up. This could lead to transient tests"
  end
end
