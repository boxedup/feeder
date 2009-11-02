require 'activesupport'

require File.join(File.dirname(__FILE__), %w[ feeder puller ])
require File.join(File.dirname(__FILE__), %w[ feeder translator ])
require File.join(File.dirname(__FILE__), %w[ feeder iterator ])

module Feeder
  @logger = Logger.new(STDOUT)
  @logger.level = Logger::FATAL
  
  def self.logger=(logger)
    @logger = logger
  end
  
  def self.logger
    @logger
  end
  
  def self.log(message)
    Feeder::logger.debug "[feeder::translator] #{message}"
  end
end