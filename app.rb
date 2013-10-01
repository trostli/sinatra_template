require 'sinatra'
require 'sinatra/activerecord'
require_relative './app/config/environments.rb'
require_relative './app/config/dotenv.rb'
require_relative './app/models/user.rb'
require_relative './app/config/omniauth.rb'
require_relative './app/config/rack_flash.rb'

SCOPE = 'email,read_stream'

enable :sessions

# turn off sinatra default X-Frame-Options for FB canvas
set :protection, :except => :frame_options

get '/' do
  erb :home
end

get '/auth/facebook/callback' do
  # This is shorthand for sending an HTTP Header of 'Location: http://yourhost.com/' and a response
  # code of 302
  flash[:notice] = "Welcome #{auth_hash[:info][:name]}"
  flash[:picture] = auth_hash[:info][:image]
  User.from_auth_hash(auth_hash)
  redirect '/'
  # http://en.wikipedia.org/wiki/HTTP_302
end

post '/canvas/' do
    # we just redirect to /auth/facebook here which will parse the
    # signed_request FB sends us, asking for auth if the user has
    # not already granted access, or simply moving straight to the
    # callback where they have already granted access.
    #
    # we pass the state parameter which we can detect in our callback
    # to do custom rendering/redirection for the canvas app page
    redirect "/auth/facebook?signed_request=#{request.params['signed_request']}&state=canvas"
end

get '/auth/failure' do
    content_type 'application/json'
    MultiJson.encode(request.env)
end

get '/user/:id' do
  @user = User.find(params[:id])
  erb :profile
end

helpers do

  # I am lazy and don't like typing env['omniauth.auth'] all the time.
  # So I made an auth_hash helper
  def auth_hash
    env['omniauth.auth']
  end
end

use Rack::Session::Cookie

use OmniAuth::Builder do
  provider :facebook, ENV['FACEBOOK_KEY'], ENV['FACEBOOK_SECRET'], :scope => SCOPE
end