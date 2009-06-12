require 'rubygems'
require 'curb'
require 'nokogiri'
gem 'mislav-will_paginate'
require 'will_paginate/collection'
require 'ostruct'
require 'activesupport'

require File.join(File.dirname(__FILE__), 'array_extensions')
require File.join(File.dirname(__FILE__), %w[ feeder feed ])
require File.join(File.dirname(__FILE__), %w[ feeder parser ])

class Feeder
  attr_reader :feeds
  
  # Feeder.new([ :feed => 'http://some.url', :elements => { :base => 'products' } ])
  def initialize(feeds)
    @feeds = feeds
  end
  
  def fetch_feeds
    
  end
end