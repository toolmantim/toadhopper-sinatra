Post [Hoptoad](http://www.hoptoadapp.com/) notifications from Sinatra

## Example

    require 'sinatra/toadhopper'
    
    set :toadhopper, :api_key => "your hoptoad API key"
    
    get "/" do
      raise "Kaboom!"
    end
    
    error do
      post_error_to_hoptoad!
      "Ouch, that hurt."
    end
