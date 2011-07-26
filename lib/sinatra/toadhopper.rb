require 'sinatra/base'
require 'toadhopper'
require 'sinatra/toadhopper/version'

module Sinatra
  module Toadhopper

    module Helpers
      # Reports the current sinatra error to Hoptoad
      def post_error_to_hoptoad!
        unless toadhopper_api_key
          STDERR.puts "Toadhopper api key not set, e.g. set :toadhopper, :api_key => 'my api key'"
          return
        end
        toadhopper = ::Toadhopper.new(toadhopper_api_key, toadhopper_options)
        toadhopper.filters = toadhopper_filters if toadhopper_filters
        toadhopper.post!(
          env['sinatra.error'],
          {
            :url => request.url,
            :params => request.params,
            :session => session.to_hash,
            :environment => ENV.to_hash,
            :framework_env => options.environment.to_s,
            :project_root => options.root,
            :notifier_name => (notifier_name = "toadhopper-sinatra"),
            :notifier_version => VERSION,
            :notifier_url => 'http://github.com/toolmantim/toadhopper-sinatra'
          },
          {'X-Hoptoad-Client-Name' => notifier_name}
        )
      end
      private
        def toadhopper_filters
          settings.toadhopper[:filters]
        end
        def toadhopper_api_key
          settings.toadhopper[:api_key]
        end
        def toadhopper_options
          settings.toadhopper.reject {|k,_| [:api_key, :filters].include?(k)}
        end
    end
    
    def self.registered(app)
      app.helpers Toadhopper::Helpers
      app.set :toadhopper, {}
    end
    
  end
  
  register Toadhopper
end