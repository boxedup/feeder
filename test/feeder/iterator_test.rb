require 'test_helper'

class Feeder::IteratorTest < Test::Unit::TestCase
  
  context '' do
    setup do
      @xml = File.expand_path(File.join( File.dirname(__FILE__), "../fixtures/feeds/dgm/output.xml" ))
    end
  
    context "calling #size" do
      context "with valid xml" do
        should "return the product count" do
          iterator = Feeder::Iterator.new(@xml)
          iterator.size.should == 2
        end
      end
    end
    
    context "calling #each" do
      context "with valid xml" do
        should "return products" do
          iterator = Feeder::Iterator.new(@xml)
          iterator.each do |product|
            product.should_not == nil
            assert product.kind_of?(Hash)
          end
        end
      end
    end
  end
end
