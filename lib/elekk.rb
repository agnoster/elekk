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

require 'elekk/armory'
require 'elekk/character'
