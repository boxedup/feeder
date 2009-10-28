require 'test_helper'

class Feeder::PullerTest < Test::Unit::TestCase
  
  context '' do
    setup do
      @uri = 'http://www.somewhere.com/product_feed.html'
      @xml = File.read(File.expand_path(File.join( File.dirname(__FILE__), "../fixtures/feeds/dgm/source.xml" ) ))
      FakeWeb.register_uri(:get, @uri, :body => @xml)
    end
  
    context "calling fetch" do      
      context "with a valid remote url" do
        should "fetch the feed" do
          object = mock()
          object.stubs(:body_str)
          Feeder::Puller.fetch(@uri)
        end
        
        should "return the path to the temporary file" do
          Feeder::Puller.fetch(@uri).ends_with? 'a.url'
        end
        
        should "download the contents of the url to the temporary file" do
          File.read(Feeder::Puller.fetch(@uri)).should == @xml
        end
      end
    end
  end
end
