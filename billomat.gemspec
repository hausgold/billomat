# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'billomat/version'

Gem::Specification.new do |spec|
  spec.name          = 'billomat'
  spec.version       = Billomat::VERSION
  spec.licenses      = ['MIT']
  spec.authors       = ['Henning Vogt']
  spec.email         = ['henning.vogt@hausgold.de']

  spec.summary       = 'Wrapper for the Billomat API'
  spec.homepage      = 'https://github.com/hausgold/billomat'

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the
  # 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing
  # to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = 'https://rubygems.org'
  else
    raise 'RubyGems 2.0 or newer is required to protect against ' \
      'public gem pushes.'
  end

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'rest-client', '~> 2.0', '>= 2.0.2'

  spec.add_development_dependency 'bundler', '>= 1.15', '< 3'
  spec.add_development_dependency 'pry', '~> 0.11'
  spec.add_development_dependency 'railties', '>= 4.2.0', '< 6.1'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rubocop', '~> 0.63.1'
  spec.add_development_dependency 'rubocop-rspec', '~> 1.31'
  spec.add_development_dependency 'simplecov', '< 0.18'
  spec.add_development_dependency 'yard', '~> 0.9.18'
  spec.add_development_dependency 'yard-activesupport-concern', '~> 0.0.1'
end
