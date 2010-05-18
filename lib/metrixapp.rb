require 'cgi'
require 'json'
require 'net/http/persistent'

class MetrixApp
  ##
  # Creates a new MetrixApp instance used to send data to your account.
  # You MUST pass your account code
  # 
  # === Usage:
  #  m = MetrixApp.new 'abc123'
  #
  def initialize(account_code)
    raise ArgumentError.new 'You MUST specify your account code' unless account_code.match /[A-Za-z0-9]{32}/
    @account_code = account_code
    @http = Net::HTTP::Persistent.new
  end
  
  ##
  # Send your data to MetrixApp. Any optional data is stored as JSON and avaiable 
  # by logging into your account and dowloading your data as CSV.
  #
  # The following options are available:
  # <tt>:event_name</tt>::  The event name, eg Signup. *MANDATORY* argument
  # <tt>:data</tt>:: Any extra data you wish to store for further analysis.
  #
  # === Usage:
  #  m = MetrixApp.new 'abc123'
  #  m.log 'Singup'
  #  m.log 'Login', :user => 'foo@example.org'
  #  m.log 'Upgrae', ['foo@example.org', 'Premium']
  #
  def log(event_name, data={})
    raise ArgumentError.new 'You MUST give your event a name' unless event_name.match /.+/
    @http.request URI.parse("http://www.metrixapp.com/log?name=#{CGI::escape(event_name)}&data=#{CGI::escape(data.to_json)}&account_code=#{@account_code}")
  end
end