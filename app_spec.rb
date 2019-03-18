require File.dirname(__FILE__) + "/app.rb"
require "rack/test"
include Rack::Test::Methods

set :environment, :test

def app
  ArticlesAPI
end

describe 'GET /articles' do
  context 'when no page query provided' do
    before(:each) do
      get '/articles'
    end

    it 'should return a status of 200' do
      expect(last_response.status).to eq(200)
    end

    it 'should return first page' do
      json = JSON.parse(last_response.body)
      expect(json['page']).to eq(1)
    end
  end

  context 'when a valid page query provided' do
    before(:each) do
      get '/articles?page=2'
    end

    it 'should return a status of 200' do
      expect(last_response.status).to eq(200)
    end

    it 'should return specified page' do
      json = JSON.parse(last_response.body)
      expect(json['page']).to eq(2)
    end
  end

  context 'when an invalid page query provided' do
    before(:each) do
      get '/articles?page=d'
    end

    it 'should return a status of 404' do
      expect(last_response.status).to eq(404)
    end

    it 'should return error message' do
      expect(last_response.body).to eq('Data not found')
    end
  end
end
