require 'typhoeus'
require 'memcached'

module Elekk
  
  # All the web requests by Elekk go through here. It would be good
  # to abstract this so it can use HTTP requesters other than Typhoeus
  # someday.
  class HTTP
    
    # Do the set-up for Typhoeus and Memcache.  Does not need to be called
    # manually, it will set itself up when a request comes in.
    def self.init
      if @initialized
        return
      end
      @initialized = true
      @hydra = Typhoeus::Hydra.new
      @cache = Memcached.new
      @hydra.cache_setter do |request|
        @cache.set request.cache_key, request.response, request.cache_timeout
      end
      @hydra.cache_getter do |request|
        @cache.get(request.cache_key) rescue nil
      end
    end
    
    # Do a synchronous request for the base url with params added,
    # default verb is GET
    def self.request(url, params=nil, opts={})
      self.init
      opts = {:method => :get, :params => params, :timeout => 10000}.merge opts
      
      request = Typhoeus::Request.new(url, opts)
      
      @hydra.queue request
      @hydra.run
      request
    end
    
    def self.xml(url, params=nil, opts={})
      request = self.request(url, params, opts)
      xml = Nokogiri::XML(request.response.body)
      if xml.errors.length > 0
        $stderr.write "XML Parse errors:\n"
        p xml.errors
        @cache.delete request.cache_key
      end
      xml
    end
    
    def self.json(url, params=nil, opts={})
      request = self.request(url, params, opts)
      begin
        json = JSON request.response.body
        raise if json.nil?
      rescue
        $stderr.write "JSON Parse errors:\n"
        @cache.delete request.cache_key
      end
      json
    end
    
  end
end