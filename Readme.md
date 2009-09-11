A Sinatra plugin for [Hoptoad](http://www.hoptoadapp.com/) error reporting that uses the toadhopper gem.

You configure the Toadhopper gem as-per usual, this plugin simply adds a `report_error_to_hoptoad!` method.

## Example

    require 'sinatra/toadhopper'
    
    Toadhopper.api_key = "YOURAPIKEY"
    
    get "/" do
      raise "Kaboom!"
    end
    
    error do
      report_error_to_hoptoad!
      "Ouch, that hurt."
    end
