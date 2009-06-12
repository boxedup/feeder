class Feeder
  class Feed
    attr_reader :url, :element_map
    
    def initialize(url, element_map)
      @url, @element_map = url, element_map
    end
    
    def fetch
      c = Curl::Easy.perform(@url)
      c.body_str
    end
  end
end