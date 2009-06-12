require 'lib/feeder.rb'

@element_map = {
  :products => "products",
  :product => "product", 
  :id => "TDProductId",
  :url => "productUrl",
  :price => "price",
  :name => "name",
  :description => "description"
}
@xml_file = File.join(File.dirname(__FILE__), %w[ test fixtures feeds tradedoubler.xml ])

@parser = Feeder::Parser.new( @xml_file, @element_map )
@parser.parse