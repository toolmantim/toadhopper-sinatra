Post [Hoptoad](http://www.hoptoadapp.com/) notifications from Sinatra

    require 'sinatra/toadhopper'
    
    set :toadhopper, :api_key => "your hoptoad API key", :filters => /password/
    
    get "/" do
      raise "Kaboom!"
    end
    
    error do
      post_error_to_hoptoad!
      "Ouch, that hurt."
    end

You can install it via rubygems:

    gem install toadhopper-sinatra
