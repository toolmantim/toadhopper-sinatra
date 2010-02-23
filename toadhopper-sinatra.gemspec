Gem::Specification.new do |s|
  s.name              = "toadhopper-sinatra"
  s.version           = "1.0.2"
  s.extra_rdoc_files  = ["README.md", "LICENSE"]
  s.summary           = "Post Hoptoad notifications from Sinatra"
  s.description       = s.summary
  s.authors           = ["Tim Lucas"]
  s.email             = "t.lucas@toolmantim.com"
  s.homepage          = "http://github.com/toolmantim/toadhopper-sinatra"
  s.require_path      = "lib"
  s.rubyforge_project = "th-sinatra"
  s.files             = %w(
                          README.md
                          Rakefile
                          LICENSE
                          lib/sinatra/toadhopper.rb
                          example.rb
                          test_example.rb
                        )
  s.has_rdoc          = true
  s.add_dependency("toadhopper", ["1.0.0"])
end
