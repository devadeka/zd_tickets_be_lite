require 'httparty'

class ZDClient
  PER_PAGE = 10
  API_URL = 'https://support.zendesk.com/api/v2/help_center/en-us/articles'.freeze

  def self.request_faqs_by_page(page)      
    response = HTTParty.get("#{API_URL}?per_page=#{PER_PAGE}&page=#{page}")
    raise StandardError, 'Not Found' if response.code != 200

    response
  end
end
