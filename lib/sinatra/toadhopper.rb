require 'sinatra/base'
require 'toadhopper'

module Sinatra
  # The Toadhopper helper methods
  module Toadhopper
    # Reports the current sinatra error to Hoptoad
    def post_error_to_hoptoad!
      options.toadhopper.each_pair {|k, v| ::Toadhopper.__send__("#{k}=", v)}
      unless ::Toadhopper.api_key
        STDERR.puts "WARNING: Ignoring hoptoad notification - :api_key not set"
        return
      end
      ::Toadhopper.post!(
        env['sinatra.error'],
        {
          :environment => ENV,
          :request     => {
            :params => params,
            :rails_root => options.root,
            :url => request.url
          },
          :session => {
            :key => 42, # Doesn't apply to Rack sessions
            :data => session
          }
        }
      )
    end
  end
  def self.registered(app)
    app.set :hoptoad, {}
  end
  helpers Toadhopper
end
