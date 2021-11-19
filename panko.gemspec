# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "panko/version"

Gem::Specification.new do |spec|
  spec.name          = "panko"
  spec.version       = Panko::VERSION
  spec.authors       = [ "Joakim Kolsjö", "Henrik Nyh" ]
  spec.email         = [ "all@barsoom.se" ]
  spec.summary       = %q{Breadcrumb trails the right way: object-oriented outside the controller.}
  spec.homepage      = "https://github.com/barsoom/panko"
  spec.license       = "MIT"
  spec.metadata      = { "rubygems_mfa_required" => "true" }

  spec.files         = Dir["lib/**/*.rb", "README.md", "LICENSE.txt"]
  spec.require_paths = [ "lib" ]

  spec.add_dependency "attr_extras"
  spec.add_dependency "breadcrumbs_on_rails"
  spec.add_dependency "i18n"
  spec.add_dependency "activesupport"
end
