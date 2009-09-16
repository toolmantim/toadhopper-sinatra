require 'rubygems'

require 'test/unit'
require 'sinatra/base'
require 'rack/test'
require 'toadhopper/test/methods'

$:.unshift File.dirname(__FILE__) + "/../lib"
require 'sinatra/toadhopper'

# Stub the Toadhopper posting

def Toadhopper.post!(*args)
  instance_variable_set(:@last_post_arguments, args)
end

def Toadhopper.last_post_arguments
  instance_variable_get(:@last_post_arguments)
end

class TestReportErrorToHoptoad < Test::Unit::TestCase
  
  class AppThatGoesBoom < Sinatra::Base

    helpers Sinatra::Toadhopper

    set :raise_errors, false
    set :sessions, true

    set :toadhopper, :api_key => "apikey", :filters => /afilter/

    get "/:id" do
      session["id"] = "sessionid"
      raise "Kaboom!"
    end

    error do
      post_error_to_hoptoad!
      "Ouch, that hurt."
    end
  end
  
  include Rack::Test::Methods

  def app; AppThatGoesBoom end

  def setup
    get "/theid"
    @error, @options, @header_options = Toadhopper.last_post_arguments
  end

  def test_api_key_set
    assert_equal "apikey", Toadhopper.api_key
  end
  def test_filter_set
    assert_equal [/afilter/], Toadhopper.filters
  end

  def test_reported_error
    assert_equal RuntimeError, @error.class
    assert_equal "Kaboom!", @error.message
  end
  
  def test_options
    assert_equal({"id" => "theid"}, @options[:parameters])
    assert_equal last_request.url, @options[:url]
    assert_equal last_request.env, @options[:cgi_data]
    assert_equal ENV, @options[:environment_vars]
    assert_equal({"id" => "sessionid"}, @options[:session_data])
  end
  
end

class TestFailsSilentWithoutApiKey < Test::Unit::TestCase
  
  class AppWithoutApiKey < Sinatra::Base
    helpers Sinatra::Toadhopper
    set :raise_errors, false
    get("/") { raise "Kaboom!" }
    error do
      post_error_to_hoptoad!
      "Error"
    end
  end
  
  include Rack::Test::Methods

  def app; AppWithoutApiKey end
  
  def test_doesnt_raise_an_error
    assert_nothing_raised { get "/" }
  end
  
end