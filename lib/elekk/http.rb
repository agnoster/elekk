require 'typhoeus'
require 'memcached'

module Elekk
  class HTTP
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
    
    def self.request(url, params=nil, opts={})
      self.init
      opts = {:method => :get, :params => params, :timeout => 1000}.merge opts
      
      request = Typhoeus::Request.new(url, opts)

      @hydra.queue request
      @hydra.run
      request.response
    end
    
  end
end