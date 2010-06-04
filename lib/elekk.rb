require 'rubygems'
require 'nokogiri'

module Elekk
  def self.default_region
    @@default_region ||= :us
  end
  
  def self.default_region=(r)
    @@default_region = r
  end  
end

require File.dirname(__FILE__) + '/elekk/armory'
require File.dirname(__FILE__) + '/elekk/character'
require File.dirname(__FILE__) + '/elekk/data'