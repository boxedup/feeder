require 'test_helper'

class Feeder::TranslatorTest < Test::Unit::TestCase
  
  context '' do    
    should "accept two arguments" do
      lambda { Feeder::Translator.new }.should raise_error
      lambda { Feeder::Translator.new('filename') }.should raise_error
      lambda { Feeder::Translator.new('filename', {}) }.should_not raise_error
    end
    
    context "#transform" do
      context "with an dgm feed" do
        setup do
          fixtures_for("dgm")
          @feeder = Feeder::Translator.new(@xml_source, @config)
        end

        should "accept no arguments" do
          lambda { @feeder.transform('unwanted argument') }.should raise_error
          lambda { @feeder.transform }.should_not raise_error
        end

        should "output the location of the output filename" do
          File.exists?(@feeder.transform).should == true
        end

        should "output our expected xml" do
          output_filename = @feeder.transform
          File.read(output_filename).should == @xml_output
        end
      end
      
      context "with an affili.net feed" do
        setup do
          fixtures_for("affili.net")
          @feeder = Feeder::Translator.new(@xml_source, @config)
        end

        should "accept no arguments" do
          lambda { @feeder.transform('unwanted argument') }.should raise_error
          lambda { @feeder.transform }.should_not raise_error
        end

        should "output the location of the output filename" do
          File.exists?(@feeder.transform).should == true
        end

        should "output our expected xml" do
          output_filename = @feeder.transform
          File.read(output_filename).should == @xml_output
        end
      end
      
      context "with a trade doubler feed" do
        setup do
          fixtures_for("tradedoubler")
          @feeder = Feeder::Translator.new(@xml_source, @config)
        end

        should "accept no arguments" do
          lambda { @feeder.transform('unwanted argument') }.should raise_error
          lambda { @feeder.transform }.should_not raise_error
        end

        should "output the location of the output filename" do
          File.exists?(@feeder.transform).should == true
        end

        should "output our expected xml" do
          output_filename = @feeder.transform
          File.read(output_filename).should == @xml_output
        end
      end
    end
    
    context "#erb_template" do
      context "against an dgm schema" do
        setup do
          fixtures_for("dgm")
          @feeder = Feeder::Translator.new(@xml_source, @config)
        end
      
        should "take no arguments" do
          lambda { @feeder.erb_template }.should_not raise_error
        end

        should "output an xsl template" do
          @feeder.erb_template.should == @xsl_template
        end
      end
      
      context "against an affili.net schema" do
        setup do
          fixtures_for("affili.net")
          @feeder = Feeder::Translator.new(@xml_source, @config)
        end
      
        should "take no arguments" do
          lambda { @feeder.erb_template }.should_not raise_error
        end
      
        should "output an xsl template" do
          @feeder.erb_template.should == @xsl_template
        end
      end
      
      context "against a tradedoubler schema" do
        setup do
          fixtures_for("tradedoubler")
          @feeder = Feeder::Translator.new(@xml_source, @config)
        end
      
        should "take no arguments" do
          lambda { @feeder.erb_template }.should_not raise_error
        end
      
        should "output an xsl template" do
          @feeder.erb_template.should == @xsl_template
        end
      end
    end    
  end
  
  def source_filename(name)
    File.expand_path(File.join( File.dirname(__FILE__), "../fixtures/feeds/#{name}/source.xml" ))
  end
  
  def output_file(name)
    File.read(File.expand_path(File.join( File.dirname(__FILE__), "../fixtures/feeds/#{name}/output.xml" )))
  end
  
  def xsl_file(name)
    File.read(File.expand_path(File.join( File.dirname(__FILE__), "../fixtures/feeds/#{name}/expected.xsl" )))
  end
  
  def config_hash(name)
    YAML.load(File.read(File.expand_path(File.join( File.dirname(__FILE__), "../fixtures/feeds/#{name}/config.yml" ) )))
  end
  
  def fixtures_for(name)
    @xml_source   = source_filename name
    @xsl_template = xsl_file name
    @xml_output   = output_file name
    @config       = config_hash name
  end
end
