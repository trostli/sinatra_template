require 'sinatra'
require 'sinatra/activerecord'
require_relative './app/config/environments.rb'
require_relative './app/models/model.rb'

get '/' do
  "hello world"
end
