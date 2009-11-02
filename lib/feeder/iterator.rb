require 'erb'
require 'tempfile'
require 'nokogiri'

# Iterator can parse and iterate over products from a translated feed
module Feeder
  class Iterator
    attr_reader :xml
    
    def initialize(filename, options={})
      log "Reading in source xml"
      @xml = File.read(filename)
    end
    
    def each
      if block_given?
        parser = Nokogiri::XML
        log "Parsing xml"
        doc, product = parser.parse(@xml), nil
        log "Iterating over each product"
        doc.xpath('//products/product').each do |product_xml|
          product = {}
          %w[images/image_url name category deep_link price description sku].each_with_index do |element, i|
            log "Reading in attribute #{element}"
            attributes = %w[image_url name category deep_link price description sku]
            product[attributes[i].intern] = product_xml.xpath(element).text
          end
          log "Yielding #{product.inspect}"
          yield product
        end
      else
        log "No block given to each, skipping"
      end
    end
    
    def size
      parser = Nokogiri::XML
      doc = parser.parse(@xml)
      doc.xpath('//products/product').size
    end
    
    protected
    
      def log(message)
        Feeder.log message
      end
  end
end