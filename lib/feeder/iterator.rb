require 'erb'
require 'tempfile'
require 'nokogiri'

# Iterator can parse and iterate over products from a translated feed
module Feeder
  class Iterator
    attr_reader :xml
    
    def initialize(filename)
      @xml = File.read(filename)
    end
    
    def each
      if block_given?
        parser = Nokogiri::XML
        doc, product = parser.parse(@xml), nil
        doc.xpath('//products/product').each do |product_xml|
          product = {}
          %w[images/image_url name category deep_link price description sku].each do |attribute|
            product[attribute.intern] = product_xml.xpath(attribute).text
          end
          yield product
        end
      end
    end
    
    def size
      parser = Nokogiri::XML
      doc = parser.parse(@xml)
      doc.xpath('//products/product').size
    end
  end
end