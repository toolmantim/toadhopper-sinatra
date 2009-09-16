[Hoptoad](http://www.hoptoadapp.com/) meets [Sinatra](http://www.sinatrarb.com/).

        _____                                ,
       /     \______                         |\        __
      | o     |     \____                    | |      |--|             __
      /\_____/           \___                |/       |  |            |~'
     /                       \              /|_      () ()            |
    |_______/                 \            //| \             |\      ()
      \______   _       ___    \          | \|_ |            | \
            /\_//      /   \    |          \_|_/            ()  |
           // //______/    /___/             |                  |
          /\/\/\      \   / \ \             @'                 ()
                        \ \   \ \      
                          \ \   \ \    
                            \ \  \ \   
                             \ \ /\/\  
                             /\/\

How?

    require 'sinatra/toadhopper'
    
    set :toadhopper, :api_key => "your hoptoad API key", :filters => /password/
    
    get "/" do
      raise "Kaboom!"
    end
    
    error do
      post_error_to_hoptoad!
      "Ouch, that hurt."
    end

Install it via rubygems:

    gem install toadhopper-sinatra
