require 'erb'
require 'tempfile'
require 'xml/xslt'

# Translator transforms xml files from one format to another.
#
# Translator takes an xml file and a set of mappings that describe what to map 
# to what.  
# 
# For example, if in the source xml file we have a <product> element, 
# we can map that to a different element on output.
#
# On the backend Translator uses xslt to transform the xml
module Feeder
  class Translator
    attr_reader :source, :mappings, :results
    
    ##
    # Initialize with a filename and an mappings hash containing mapped elements
    #
    # @param [String] a filename
    # @param [Hash] mapping mappings    
    def initialize(source, mappings, options={})
      Feeder::logger = options[:logger] if options[:logger]
      Feeder::logger.level = Logger::DEBUG if options[:verbose]
      @source, @mappings = source, mappings
    end
    
    ##
    # Transform the results of the source xml file using the mappings given
    # Essentially we use erb to built an xslt template and then execute it on 
    # the xml file
    #
    # @return [String] the filename of the output file
    def transform
      xslt = XML::XSLT.new
      xslt.xml = File.read(@source)
      output_location = ""
      temp_file do |location|
        output_location = location
        begin
          xslt.xsl = erb_template
          xslt.serve
        rescue => x
          Feeder::logger.debug "[feeder] #{x}"
          Feeder::logger.debug "[feeder] mappings: #{@mappings.inspect}"
          Feeder::logger.debug "[feeder] erb_template: #{erb_template}"
        end
      end
      output_location
    end

    ##
    # The xsl template generated from erb template (at templates/default.xsl.erb), 
    # transformed with mappings supplied in {Translator#initialize}
    #
    # @return [String] results of the erb generated template
    def erb_template
      template = File.read(File.join(File.dirname(__FILE__), %w{ templates default.xsl.erb }))
      erb = ERB.new(template)
      @mappings["elements"].delete_if {|k,v| v.nil? || v == ""}
      mappings = @mappings["elements"]
      erb.result(binding)
    end
    
    protected
    
      def temp_file
        if block_given?
          temp_file = Tempfile.new(File.basename(@source))
          content = yield temp_file.path
          temp_file.write content
          temp_file.close
        end
      end
  end
end