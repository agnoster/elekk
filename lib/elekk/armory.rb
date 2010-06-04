require 'typhoeus'
require 'memcached'

module Elekk
  class Armory

    attr_accessor :realm
    attr_reader :region

    def initialize(*keywords)
      opts = keywords.pop if keywords.last.class == {}.class
      @realm = keywords.shift if keywords.length > 0
      @region = keywords.shift if keywords.length > 0

      if opts
        @realm ||= opts[:realm]
        @region ||= opts[:region]
      end

      @region ||= Elekk::default_region

      @hydra = Typhoeus::Hydra.new
      @cache = Memcached.new
      @hydra.cache_setter do |request|
        @cache.set request.cache_key, request.response, request.cache_timeout
      end
      @hydra.cache_getter do |request|
        @cache.get(request.cache_key) rescue nil
      end
    end

    def character(name)
      Character.new name, @realm, :region => @region, :armory => self
    end

    def base
      "http://#{@region}.wowarmory.com/"
    end

    def get_xml(resource, params=nil)
      response = get_url resource+'.xml', params
      Nokogiri::XML(response.body)
    end
    
    def url(url)
      base + url
    end

    def get_url(url, params=nil)
      request = Typhoeus::Request.new(self.base + url,
      :method => :get,
      :params => params,
      :user_agent => 'Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.6; en-US; rv:1.9.1.9) Gecko/20100315 Firefox/3.5.9',
      :timeout => 1000,
      :cache_timeout => 24*3600)
      @hydra.queue request
      @hydra.run
      request.response
    end
  end
end