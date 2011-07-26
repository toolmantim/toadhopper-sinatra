require 'sinatra'
require 'sinatra/toadhopper'

set :airbrake, :api_key => "apikey", :filters => /password/

post "/register" do
  session[:user_id] = 42
  raise "Kaboom!"
end

error do
  post_error_to_airbrake!
  "Ouch, that hurt."
end
