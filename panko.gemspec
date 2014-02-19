# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'panko/version'

Gem::Specification.new do |spec|
  spec.name          = "panko"
  spec.version       = Panko::VERSION
  spec.authors       = ["Joakim Kolsjö", "Henrik Nyh"]
  spec.email         = ["all@barsoom.se"]
  spec.summary       = %q{Breadcrumb trails the right way: object-oriented outside the controller.}
  spec.homepage      = "https://github.com/barsoom/panko"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "attr_extras"
  spec.add_dependency "breadcrumbs_on_rails"
  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
end
