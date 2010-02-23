toadhopper_dir = "#{File.dirname(__FILE__)}/../toadhopper"
raise "#{toadhopper_dir} does not exist" unless File.directory?(toadhopper_dir)
$:.unshift "#{toadhopper_dir}/lib"

$:.unshift "#{File.dirname(__FILE__)}/lib"

require "#{File.dirname(__FILE__)}/example"
Sinatra::Application.set :environment, :production

require 'exemplor'

require 'rack/test'
require 'rr'

eg.helpers do
  include Rack::Test::Methods
  include RR::Adapters::RRMethods
  def app
    Sinatra::Application
  end
end

eg.setup do
  RR.reset
  
  @toadhopper = ::Toadhopper.new("")
  stub(::Toadhopper).new do |api_key|
    @api_key = api_key
    @toadhopper
  end
  
  stub(@toadhopper).post! do |*args|
    @error, @options, @header = *args
  end
end

eg "Posting" do
  post "/register", :name => "Billy", :password => "Bob"
  
  Check(@api_key).is("apikey")

  Check(@toadhopper.filters).is([/password/])

  Check(@error.class).is(RuntimeError)
  Check(@error.message).is("Kaboom!")

  Check(@options[:environment]).is(ENV.to_hash)
  Check(@options[:url]).is("http://example.org/register")
  Check(@options[:params]).is({"name"=>"Billy", "password"=>"Bob"})
  Check(@options[:framework_env]).is("production")
  Check(@options[:project_root]).is(app.root)
  Check(@options[:session]).is({:user_id => 42})
  Check(@options[:notifier_name]).is("toadhopper-sinatra")

  Check(@header['X-Hoptoad-Client-Name']).is("toadhopper-sinatra")
end