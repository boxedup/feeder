require 'test_helper'

class Feeder::ParserTest < Test::Unit::TestCase
  
  context '' do
    setup do
      @element_map = {
        :products    => "products",
        :product     => "product", 
        :uid         => "sku",
        :url         => "ctpage",
        :price       => "price",
        :name        => "name",
        :description => "description"
      }
      @xml_file = File.join(File.dirname(__FILE__), %w[ .. fixtures feeds apple.xml ])
    end
  
    context "on initialization" do
      should "require a url and elements" do
        lambda { Feeder::Parser.new }.should raise_error
        lambda { Feeder::Parser.new( @xml_file, @element_map) }.should_not raise_error
      end
    end
  
    context "when initialized" do
      setup do
        @parser = Feeder::Parser.new( @xml_file, @element_map )
      end
      
      context "when parsing" do
        should "map element values to an OpenStruct" do
          @parser.parse
          @parser.products.size.should == 2
          @parser.products.each do |product|
            @element_map.keys.each do |element|
              product.should respond_to(element) unless [ :products, :product ].include? element
            end
          end
        end
      end
    end
  end
end
