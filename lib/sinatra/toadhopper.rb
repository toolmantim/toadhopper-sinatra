require 'sinatra/base'
require 'toadhopper'

module Sinatra
  module Toadhopper
    # Reports the current sinatra error to Hoptoad.
    # 
    # Usage:
    #
    #   gem "toadhopper"
    #   require 'sinatra/toadhopper'
    #
    #   Toadhopper.api_key = "abc123"
    #
    #   get "/" do
    #     raise "Kaboom!"
    #   end
    #
    #   error do
    #     report_error_to_hoptoad!
    #     "Ouch, that hurt."
    #   end
    def report_error_to_hoptoad!
      # TODO:
    end
  end
  helpers Toadhopper
end
