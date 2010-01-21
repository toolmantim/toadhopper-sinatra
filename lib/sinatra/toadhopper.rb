require 'sinatra/base'
require 'toadhopper'

module Sinatra
  # The Toadhopper helper methods
  module ToadHopper
    VERSION = "0.10"
    # Reports the current sinatra error to Hoptoad
    def post_error_to_hoptoad!
      unless options.toadhopper && options.toadhopper[:api_key]
        STDERR.puts "ToadHopper api key not set, e.g. set :toadhopper, :api_key => 'my api key'"
      end
      toadhopper = ToadHopper(options.toadhopper[:api_key])
      toadhopper.filters = options.toadhopper[:filters] if options.toadhopper[:filters]
      toadhopper.post!(
        env['sinatra.error'],
        {
          :url => request.url,
          :request => request,
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
  helpers ToadHopper
end