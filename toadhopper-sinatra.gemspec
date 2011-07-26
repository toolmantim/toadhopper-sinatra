# -*- encoding: utf-8 -*-

$: << File.expand_path('../lib', __FILE__)

require 'sinatra/toadhopper/version'

Gem::Specification.new do |s|
  s.name        = 'toadhopper-sinatra'
  s.version     = Sinatra::Toadhopper::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ['Tim Lucas', 'Gabriel Horner', 'Kyle Drake']
  s.email       = ['t.lucas@toolmantim.com']
  s.homepage    = 'http://github.com/toolmantim/toadhopper-sinatra'
  s.summary     = %q{Post Hoptoad notifications from Sinatra}

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ['lib']
  s.extra_rdoc_files  = ['README.md', 'LICENSE', 'example.rb']

  s.add_dependency 'sinatra'
  s.add_dependency 'toadhopper'
  
  s.add_development_dependency 'rake'
  s.add_development_dependency 'exemplor'
  s.add_development_dependency 'rr'
  s.add_development_dependency 'rack-test'
end
