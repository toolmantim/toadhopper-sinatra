require 'bundler/setup'

Bundler::GemHelper.install_tasks

desc "Run tests"
task :test do
  exec "/usr/bin/env bundle exec ruby #{File.dirname(__FILE__)}/test_example.rb"
end
