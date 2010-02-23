Bundler.setup(:default, :development, :test)
Bundler.require(:development, :test)

Jeweler::Tasks.new do |s|
  s.name     = "toadhopper-sinatra"
  s.summary  = "Post Hoptoad notifications from Sinatra"
  s.email    = "t.lucas@toolmantim.com"
  s.homepage = "http://github.com/toolmantim/toadhopper-sinatra"
  s.authors  = ["Tim Lucas"]
  s.extra_rdoc_files  = ["README.md", "LICENSE", "example.rb"]

  require File.join(File.dirname(__FILE__), 'lib', 'sinatra', 'toadhopper')
  s.version  = Sinatra::Toadhopper::VERSION

  require 'bundler'
  bundle = Bundler::Definition.from_gemfile("Gemfile")
  bundle.dependencies.
    select { |d| d.groups.include?(:default) || d.groups.include?(:runtime) }.
    each   { |d| s.add_dependency(d.name, d.version_requirements.to_s)  }
end

desc "Run tests"
task :test do
  exec "/usr/bin/env ruby #{File.dirname(__FILE__)}/test_example.rb"
end
