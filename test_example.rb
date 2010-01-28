require 'test/unit'

require 'rr'
class Test::Unit::TestCase
  include RR::Adapters::TestUnit
end

require 'rack/test'

toadhopper_dir = "#{File.dirname(__FILE__)}/../toadhopper"
raise "#{toadhopper_dir} does not exist" unless File.directory?(toadhopper_dir)
$:.unshift "#{toadhopper_dir}/lib"

$:.unshift "#{File.dirname(__FILE__)}/lib"

require "#{File.dirname(__FILE__)}/example"

Sinatra::Application.set :environment, :production

class Sinatra::ToadHopper::TestExample < Test::Unit::TestCase
  
  include Rack::Test::Methods

  def app; Sinatra::Application end

  def setup
    @toadhopper = ::ToadHopper.new("")
    stub(::ToadHopper).new do |api_key|
      @api_key = api_key
      @toadhopper
    end
    stub(@toadhopper).post! do |*args|
      @error, @options, @header = *args
    end

    post "/register", :name => "Billy", :password => "Bob"
  end

  def test_api_key_set
    assert_equal "apikey", @api_key
  end
  def test_filter_set
    assert_equal [/password/], @toadhopper.filters
  end
  def test_reported_error
    assert_equal RuntimeError, @error.class
    assert_equal "Kaboom!", @error.message
  end

  def test_options
    assert_equal ENV.to_hash,                          @options[:environment]
    assert_equal "http://example.org/register",        @options[:url]
    assert_equal({"name"=>"Billy", "password"=>"Bob"}, @options[:request].params)
    assert_equal "production",                         @options[:framework_env]
    assert_equal app.root,                             @options[:project_root]
    assert_equal({:user_id => 42},                     @options[:session])
    assert_equal "toadhopper-sinatra",                 @options[:notifier_name]
  end
  
  def test_header_options
    assert_equal "toadhopper-sinatra", @header['X-Hoptoad-Client-Name']
  end
  
end