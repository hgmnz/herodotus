# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "herodotus/version"

Gem::Specification.new do |s|
  s.name        = "herodotus"
  s.version     = Herodotus::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Harold Giménez"]
  s.email       = ["harold.gimenez@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{The father of your project's history}
  s.description = %q{Reads your git tags and commit messages to keep the changelog updated}

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency 'grit'

  s.add_development_dependency 'redgreen'
  s.add_development_dependency 'rake'
  s.add_development_dependency 'ruby-debug19'
end
