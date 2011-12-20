require 'sinatra/base'
require 'toadhopper'
require 'sinatra/toadhopper/version'

module Sinatra
  module Toadhopper

    module Helpers
      # Reports the current sinatra error to Hoptoad
      def post_error_to_airbrake!
        unless airbrake_api_key
          STDERR.puts "Airbrake api key not set, e.g. set :airbrake, :api_key => 'my api key'"
          return
        end
        toadhopper = ::Toadhopper.new(airbrake_api_key, airbrake_options)
        toadhopper.filters = airbrake_filters if airbrake_filters
        toadhopper.post!(
          env['sinatra.error'],
          {
            :url => request.url,
            :params => request.params,
            :session => session.to_hash,
            :environment => ENV.to_hash,
            :framework_env => settings.environment.to_s,
            :project_root => settings.root,
            :notifier_name => (notifier_name = "toadhopper-sinatra"),
            :notifier_version => VERSION,
            :notifier_url => 'http://github.com/toolmantim/toadhopper-sinatra'
          },
          {'X-Hoptoad-Client-Name' => notifier_name}
        )
      end
      private
        def airbrake_filters
          settings.airbrake[:filters]
        end
        def airbrake_api_key
          settings.airbrake[:api_key]
        end
        def airbrake_options
          settings.airbrake.reject {|k,_| [:api_key, :filters].include?(k)}
        end
    end
    
    def self.registered(app)
      app.helpers Toadhopper::Helpers
      app.set :airbrake, {}
    end
    
  end
  
  register Toadhopper
end