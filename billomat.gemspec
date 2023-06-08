# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'billomat/version'

Gem::Specification.new do |spec|
  spec.name = 'billomat'
  spec.version = Billomat::VERSION
  spec.authors = ['Hermann Mayer', 'Henning Vogt']
  spec.email = ['hermann.mayer92@gmail.com', 'henning.vogt@hausgold.de']

  spec.license = 'MIT'
  spec.summary = 'Wrapper for the Billomat API'
  spec.description = 'Wrapper for the Billomat API'

  base_uri = "https://github.com/hausgold/#{spec.name}"
  spec.metadata = {
    'homepage_uri' => base_uri,
    'source_code_uri' => base_uri,
    'changelog_uri' => "#{base_uri}/blob/master/CHANGELOG.md",
    'bug_tracker_uri' => "#{base_uri}/issues",
    'documentation_uri' => "https://www.rubydoc.info/gems/#{spec.name}"
  }

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end

  spec.bindir = 'exe'
  spec.executables = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.required_ruby_version = '>= 2.5'

  spec.add_runtime_dependency 'rest-client', '~> 2.1'
end
