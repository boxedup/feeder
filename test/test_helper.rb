require 'rubygems'
require 'test/unit'
require 'shoulda'
require 'matchy'
require 'mocha'
require 'nokogiri'
require 'fakeweb'
require 'yaml'

begin require "redgreen" unless ENV['TM_CURRENT_LINE']; rescue LoadError; end

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'feeder'

FakeWeb.allow_net_connect = false

class Test::Unit::TestCase

end