require File.dirname(__FILE__) + "/test_helper.rb"

class TestReportErrorToHoptoad < Test::Unit::TestCase
  
  require 'sinatra/base'
  
  class AppThatGoesBoom < Sinatra::Base

    require 'sinatra/toadhopper'

    Toadhopper.api_key = "abc123"

    get "/" do
      raise "Kaboom!"
    end

    error do
      report_error_to_hoptoad!
      "Ouch, that hurt."
    end
  end
  
  include Rack::Test::Methods
  include Toadhopper::Test

  def app; AppThatGoesBoom end

  def setup
    stub_toadhopper_post!
  end

  def test_reports_errors
    get "/"
    assert_equal "RuntimeError", last_toadhopper_post.error.class
    assert_equal "Kaboom!", last_toadhopper_post.error.message
  end
  
end
