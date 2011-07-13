require 'sinatra/base'
require 'toadhopper'
require 'sinatra/toadhopper/version'

module Sinatra
  # The Toadhopper helper methods
  module Toadhopper
    def self.registered(app)
      app.helpers Toadhopper
    end

    # Reports the current sinatra error to Hoptoad
    def post_error_to_hoptoad!
      unless options.toadhopper && options.toadhopper[:api_key]
        STDERR.puts "Toadhopper api key not set, e.g. set :toadhopper, :api_key => 'my api key'"
        return
      end
      filters = options.toadhopper.delete(:filters)
      toadhopper = ::Toadhopper.new(options.toadhopper.delete(:api_key), options.toadhopper)
      toadhopper.filters = filters if filters
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
  end
  register Toadhopper
end