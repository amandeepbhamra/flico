# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name = 'flico'
  spec.version       = '1.0.0'
  spec.summary       = 'A CLI tool to create collage from keywords using Flickr'
  spec.homepage      = 'https://github.com/amandeepbhamra/flico'
  spec.license       = 'MIT'

  spec.authors       = ['Amandeep Singh Bhamra']
  spec.email         = ['amandeep.bhamra@gmail.com']

  spec.files         = `git ls-files -z`.split("\x0")
  spec.bindir        = 'bin'
  spec.executables   = 'flico'
  spec.require_paths = ['lib']

  spec.add_dependency 'flickraw', '~> 0.9.10'
  spec.add_dependency 'mini_magick', '~> 4.12'
  spec.add_development_dependency 'bundler', '~> 2.4', '>= 2.4.14'
  spec.add_development_dependency 'rake', '~> 13.0', '>= 13.0.6'
  spec.add_development_dependency 'rspec', '~> 3.12'
end
