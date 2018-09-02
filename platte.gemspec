# frozen_string_literal: true

require './lib/platte/version'

Gem::Specification.new do |s|
  s.name = 'platte'
  s.version = Platte::VERSION
  s.authors = ['Thomas Bretzke']
  s.homepage = 'https://github.com/kiefernwald/platte'
  s.summary = 'A static generator tool for static HTML pages combined from modules.'
  s.license = 'ISC'

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  raise 'RubyGems 2.0 or newer is required to protect against public gem pushes.' unless s.respond_to?(:metadata)
  s.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"

  s.files = Dir['.gemspec', 'lib/**/*.rb', 'license.txt', 'readme.md']

  s.required_ruby_version = '~> 2.3'
  s.add_development_dependency 'bundler', '~> 1.16'
  s.add_development_dependency 'rake', '~> 10.0'
  s.add_development_dependency 'rspec', '~> 3.0'
  s.add_development_dependency 'rubocop', '~> 0.49.0'
end
