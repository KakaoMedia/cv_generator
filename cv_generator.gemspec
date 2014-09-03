# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'cv_generator/version'

Gem::Specification.new do |s|
  s.name        = "cv_generator"
  s.version     = CvGenerator::VERSION
  s.authors     = ["Gerardo Ortega"]
  s.email       = ["geraldavid7@gmail.com"]
  s.homepage    = "http://g3ortega.com"
  s.summary     = "An easier way to generate a CV in PDF based in LinkedIn Profile API"
  s.description = "An easier way to create CVs using linkedin profile API."

  s.files         = `git ls-files -z`.split("\x0")
  s.executables   = s.files.grep(%r{^bin/}) { |f| File.basename(f) }
  s.test_files    = s.files.grep(%r{^(test|spec|features)/})
  s.require_paths = ['lib']

  s.add_dependency 'prawn', '~> 1.2.1'
  s.add_dependency 'linkedin', '~> 1.0.0'

  s.add_development_dependency 'rake', '~> 10.3.1'
  s.add_development_dependency 'bundler', '~> 1.5'
  s.add_development_dependency 'rspec', '~> 2.14.1'

end


