require 'cgi'
require 'json'
require 'net/http/persistent'

class MetrixApp
  def initialize(account_code)
    @account_code = account_code
    @http = Net::HTTP::Persistent.new
  end
  
  def log(event_name, data={})
    @http.request URI.parse("http://www.metrixapp.com/log?name=#{CGI::escape(event_name)}&data=#{CGI::escape(data.to_json)}&account_code=#{@account_code}")
  end
end