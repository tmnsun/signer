# frozen_string_literal: true

require File.expand_path('lib/wsse_signer/version', __dir__)

Gem::Specification.new do |gem|
  gem.authors       = ['Edgars Beigarts']
  gem.email         = ['edgars.beigarts@gmail.com']
  gem.description   = 'WS Security XML signer'
  gem.summary       = gem.description
  gem.homepage      = ''

  gem.files         = Dir.glob('lib/**/*') + %w[README.md CHANGELOG.md LICENSE]
  gem.test_files    = Dir.glob('spec/**/*')
  gem.executables   = []

  gem.name          = 'wsse_signer'
  gem.require_paths = ['lib']
  gem.version       = WsseSigner::VERSION

  gem.required_ruby_version = '>= 2.1.0'

  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'rspec'

  gem.add_runtime_dependency 'nokogiri', '>= 1.5.1'
end
