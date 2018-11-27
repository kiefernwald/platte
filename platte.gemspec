# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift lib unless $LOAD_PATH.include?(lib)
require 'platte/version'

Gem::Specification.new do |s|
  s.name = 'platte'
  s.version = Platte::VERSION
  s.authors = ['Thomas Bretzke']
  s.homepage = 'https://github.com/kiefernwald/platte'
  s.summary = 'A static generator tool for static HTML pages combined from modules.'
  s.license = 'MIT'

  s.executables = %w[platte]
  s.require_paths = %w[lib]
  s.files = Dir['.gemspec', 'lib/**/*.rb', 'bin/*', 'license.txt', 'readme.md']

  s.required_ruby_version = '~> 2.3'
  s.add_development_dependency 'bundler', '~> 1.16'
  s.add_development_dependency 'rake', '~> 10.0'
  s.add_development_dependency 'rspec', '~> 3.0'
  s.add_development_dependency 'rubocop', '~> 0.49.0'
end
