# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
	
	spec.version       = '0.0.2'
	spec.name          = 'flico'
	spec.summary       = %q{CLI tool to create collage using Flickr}
	spec.homepage      = "https://github.com/amandeepbhamra/flico"
	spec.license       = 'MIT'

	spec.authors       = ['Amandeep Bhamra']
	spec.email         = ["amandeep.bhamra@gmail.com"]
	
	spec.files         = `git ls-files -z`.split("\x0")
	spec.bindir        = 'bin'
	spec.executables   = 'flico'
	spec.require_paths = ['lib']

	spec.add_dependency 'flickraw'
  	spec.add_dependency 'mini_magick'
	spec.add_development_dependency "bundler"
	spec.add_development_dependency "rake"
	spec.add_development_dependency "rspec"
end
