require 'helper'

class TestMetrixapp < Test::Unit::TestCase
  test "should require an account code" do
    assert_raise(ArgumentError) { MetrixApp.new }
    assert_raise(ArgumentError) { MetrixApp.new '123' }
    assert_nothing_raised { MetrixApp.new '1z'*16 }
  end
  
  test "should require a log event name" do
    m = MetrixApp.new '1'*32
    assert_raise(ArgumentError) { m.log }
    assert_nothing_raised { m.log 'foo' }
  end
  
  test "should send data to MetrixApp API endpoint" do
    Net::HTTP::Persistent.any_instance.expects(:request)
    MetrixApp.new('1'*32).log 'foo'
  end
  
  test "should log extra data as JSON" do
    mock_log_request 'foo', 'foo'
    MetrixApp.new(account_code).log 'foo', 'foo'
  end
  
  test "should accept symbol as event name" do
    assert_nothing_raised { MetrixApp.new(account_code).log :foo}
  end
  
  def mock_log_request(name, data)
    event_name = CGI::escape name
    event_data = CGI::escape data.to_json
    
    uri = URI.expects(:parse).
      with("http://www.metrixapp.com/log?name=#{event_name}&data=#{event_data}&account_code=#{account_code}")
      
    Net::HTTP::Persistent.any_instance.expects(:request)
  end
  
  def account_code
    @account_code ||= '1'*32
  end
end
