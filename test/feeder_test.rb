require 'test_helper'

class FeederTest < Test::Unit::TestCase
  
  context "on initialization" do
    should "require an array of feeds and options" do
      lambda { Feeder.new }.should raise_error
      lambda { Feeder.new([]) }.should_not raise_error
    end
  end

  context '' do
    setup do
      @url = 'http://www.somewhere.com/product_feed.html'
      FakeWeb.register_uri(:get, @url, :string => fixture(:feeds, :apple))
      @feeder = Feeder.new( [:feed => 'http://www.somewhere.com/product_feed.html', :elements => {} ])
    end
    context "when initialized" do
      should "have enumerable feeds" do
        @feeder.feeds.should be_kind_of(Enumerable)
      end
    end
  
    context "after initialization" do
      should "fetch" do
      
      end
    end
  end  
  
end
