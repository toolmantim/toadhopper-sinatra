require 'sinatra/base'
require 'toadhopper'

module Sinatra
  # The Toadhopper helper methods. Simply require this method from within your Sinatra app.
  module Toadhopper
    # Reports the current sinatra error to Hoptoad.
    def post_error_to_hoptoad!
      if options.respond_to?(:toadhopper)
        options.toadhopper.each_pair {|k, v| ::Toadhopper.__send__("#{k}=", v)}
      end
      unless ::Toadhopper.api_key
        STDERR.puts "WARNING: Ignoring hoptoad notification - :api_key not set"
        return
      end
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
