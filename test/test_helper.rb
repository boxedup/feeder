require 'rubygems'
require 'test/unit'
require 'shoulda'
require 'matchy'
require 'mocha'
require 'nokogiri'
require 'fakeweb'

begin require "redgreen" unless ENV['TM_CURRENT_LINE']; rescue LoadError; end

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'feeder'

FakeWeb.allow_net_connect = false

class Test::Unit::TestCase

end

def fixture(fixture_type, name)
  fixture_filename = File.expand_path(File.join( File.dirname(__FILE__), "fixtures/#{fixture_type.to_s}/small/#{name.to_s}.xml" ) )
  doc = Nokogiri::HTML(open(fixture_filename))
  doc.content
end