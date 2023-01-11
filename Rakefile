# frozen_string_literal: true

require 'bundler/gem_tasks'
require 'rspec/core/rake_task'
require 'countless/rake_tasks'

RSpec::Core::RakeTask.new(:spec)

task default: :spec

# Configure all code statistics directories
Countless.configure do |config|
  config.stats_base_directories = [
    { name: 'Top-levels', dir: 'lib',
      pattern: %r{/lib(/billomat)?/[^/]+\.rb$} },
    { name: 'Top-levels specs', test: true, dir: 'spec',
      pattern: %r{/spec(/billomat)?/[^/]+_spec\.rb$} },
    { name: 'Actions', pattern: 'lib/billomat/actions/**/*.rb' },
    { name: 'Models matchers', pattern: 'lib/billomat/models/**/*.rb' },
    { name: 'Models matchers specs', test: true,
      pattern: 'spec/models/**/*_spec.rb' }
  ]
end
