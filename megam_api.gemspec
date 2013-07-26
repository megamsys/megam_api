# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "megam/api/version"

Gem::Specification.new do |s|
  s.name        = "megam_api"
  s.version     = Megam::API::VERSION
  s.authors     = ["Kishorekumar Neelamegam, Thomas Alrin, Subash Sethurajan"]
  s.email       = ["nkishore@megam.co.in","alrin@megam.co.in","subash.avc@gmail.com"]
  s.homepage    = "http://github.com/indykish/megam_api"
  s.license = "Apache V2"
  sextra_rdoc_files = ["README.md", "LICENSE" ]
  s.summary     = %q{Ruby Client for the Megam}
  s.description = %q{Ruby Client for the Megam PaaS}
  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_runtime_dependency 'excon'
  s.add_runtime_dependency 'highline'
  s.add_runtime_dependency 'yajl-ruby'
  s.add_development_dependency 'minitest'
  s.add_development_dependency 'rake'
end