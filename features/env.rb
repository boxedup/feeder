$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'feeder'
require 'matchy'
require 'test/unit/assertions'

World(Test::Unit::Assertions)

def fixture(fixture_type, name)
  fixture_filename = File.expand_path(File.join( File.dirname(__FILE__), "../test/fixtures/#{fixture_type.to_s}/#{name.to_s}.xml" ) )
  doc = Nokogiri::HTML(open(fixture_filename))
  doc.content
end