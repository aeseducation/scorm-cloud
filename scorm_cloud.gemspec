# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "scorm_cloud/version"

Gem::Specification.new do |s|
  s.name        = "scorm_cloud"
  s.version     = ScormCloud::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Ken Richard"]
  s.email       = ["kenrichar@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{Rustici Scorm Cloud Web Service API Wrapper}
  s.description = %q{Rustici Scorm Cloud Web Service API Wrapper}
  s.license     = 'MIT'

  s.rubyforge_project = "scorm_cloud"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = ["scorm_cloud"]
  s.default_executable = "bin/scorm_cloud"
  s.require_paths = ["lib"]

  s.add_dependency('multipart-post')
end
