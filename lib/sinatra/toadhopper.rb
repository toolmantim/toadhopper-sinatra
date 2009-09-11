require 'sinatra/base'
require 'toadhopper'

module Sinatra
  module Toadhopper
    # Reports the current sinatra error to Hoptoad. Don't forget Hoptad.api_key before-hand
    def report_error_to_hoptoad!
      # TODO:
    end
  end
  helpers Toadhopper
end
