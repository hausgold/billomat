# frozen_string_literal: true

require 'simplecov'
SimpleCov.command_name 'specs'

require 'bundler/setup'
require 'billomat'

# Load all support helpers and shared examples
Dir[File.join(__dir__, 'support', '**', '*.rb')].each { |f| require f }

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  # Enable the focus inclusion filter and run all when no filter is set
  # See: http://bit.ly/2TVkcIh
  config.filter_run(focus: true)
  config.run_all_when_everything_filtered = true
end

# Set Billomat configuration
# Is available in all Specs
Billomat.configure do |config|
  config.api_key = '1234'
  config.subdomain = 'example'
  config.app_id = '51234'
  config.app_secret = 'c3df6e3707be6afa684e0e35bde6d732'
end
