require 'json'
require 'sinatra'
require 'redis-sinatra'
require_relative 'ZDClient'

class ArticlesAPI < Sinatra::Base
  register Sinatra::Cache

  get '/articles' do
    content_type :json

    page = (params[:page] || 1).to_i

    response = settings.cache.fetch("zd_#{page}", expires_in: 360) do
      begin
        zd_resp = ZDClient.request_faqs_by_page(page)
      rescue
	halt 404, 'Data not found' and return
      end
    end

    @json_resp = JSON.parse(response.to_s)
    {page: page, page_count: page_count, articles: articles}.to_json
  end

  private
  def page_count
    @json_resp['page_count']
  end

  def articles
    @json_resp['articles'].map do |article|
      article.slice('id', 'title', 'body')
    end
  end

  def return_404
    status 404
    body "Data not found"
  end
end
