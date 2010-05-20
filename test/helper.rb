require 'rubygems'
require 'test/unit'
require 'redgreen'
require 'active_support/testing/declarative'
require 'mocha'

$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'metrixapp'

class Test::Unit::TestCase
  extend ActiveSupport::Testing::Declarative
end
