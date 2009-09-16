require 'sinatra/base'
require 'toadhopper'

module Sinatra
  module Toadhopper
    # Reports the current sinatra error to Hoptoad.
    def post_error_to_hoptoad!
      unless api_key = options.respond_to?(:toadhopper) && options.toadhopper[:api_key]
        STDERR.puts "WARNING: Ignoring post_error_to_hoptoad! - :api_key not set"
        return
      end
      ::Toadhopper.api_key = api_key
      ::Toadhopper.post!(
        env['sinatra.error'],
        {
          :parameters       => params,
          :url              => request.url,
          :cgi_data         => request.env,
          :environment_vars => ENV,
          :session_data     => session.to_hash
        }
      )
    end
  end
  helpers Toadhopper
end
