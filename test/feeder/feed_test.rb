require 'test_helper'

class Feeder::FeedTest < Test::Unit::TestCase
  
  context '' do
    setup do
      @url = 'http://www.somewhere.com/product_feed.html'
      FakeWeb.register_uri(:get, @url, :string => fixture(:feeds, :apple))
    end
    
    context "on initialization" do
      should "require a url and elements" do
        lambda { Feeder::Feed.new }.should raise_error
        lambda { Feeder::Feed.new('http://a.url', {}) }.should_not raise_error
      end
    end
  
    context "after initialization" do
      setup do
        @feed = Feeder::Feed.new( @url, @element_map )
      end
      
      context "with a valid remote url" do
        should "fetch the feed" do
          object = mock()
          object.stubs(:body_str)
          Curl::Easy.expects(:perform).with(@url).returns(object)
          @feed.fetch
        end
        
        should_eventually "return the feed as a string" do
          Curl::Easy.expects(:perform).with(@url)
          @feed.fetch.should be_kind_of(String)
        end
      end
    end

  end  
  
end
