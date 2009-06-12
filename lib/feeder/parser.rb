require 'ostruct'
require 'rmem'

class Feeder
  class Parser
    attr_reader :filename, :element_map, :products
    
    def initialize(filename, element_map)
      @filename, @element_map = filename, element_map
    end
    
    def parse
      @products = []

      doc = Nokogiri::XML(File.read(@filename))

      doc.xpath("//#{@element_map[:products]}/#{@element_map[:product]}").each do |product|
        grab_product_details(product)
        product = OpenStruct.new( :uid         => @uid, 
                                  :name        => @name, 
                                  :description => @description, 
                                  :url         => @url, 
                                  :price       => @price )
        @products << product
      end
      @products
    end
    
    private
    
      def sanitize(text)
        text.strip
      end
      
      def grab_product_details(product)
        @uid          = sanitize(product.search("#{@element_map[:uid]}").inner_text)
        @name         = sanitize(product.search("#{@element_map[:name]}").inner_text)
        @description  = sanitize(product.search("#{@element_map[:description]}").inner_text)
        @url          = sanitize(product.search("#{@element_map[:url]}").inner_text)
        @price        = sanitize(product.search("#{@element_map[:price]}").inner_text)
      end
  end
end