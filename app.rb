require 'json'
require 'sinatra'
require 'redis-sinatra'
require 'sinatra/cross_origin'

class SampleApp < Sinatra::Base
  set :bind, '0.0.0.0'
  configure do
    enable :cross_origin
  end
  before do
    response.headers['Access-Control-Allow-Origin'] = '*'
  end
  
  # routes...
  options "*" do
    response.headers["Allow"] = "GET, PUT, POST, DELETE, OPTIONS"
    response.headers["Access-Control-Allow-Headers"] = "Authorization, Content-Type, Accept, X-User-Email, X-Auth-Token"
    response.headers["Access-Control-Allow-Origin"] = "*"
    200
  end

  register Sinatra::Cache

  get '/articles' do
    json = JSON.parse(settings.cache.fetch('greet', expires_in: 60) { '{"foo":"bar", "ping":"pong"}' })
    p json
    "TEST"
  end
end
