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
    end

    def character(name)
      Character.new name, @realm, :region => @region, :armory => self
    end

    def base
      "http://#{@region}.wowarmory.com/"
    end

    def get_xml(resource, params=nil)
      response = HTTP.request(url(resource+'.xml'), params, {
        :cache_timeout => 24*3600,
        :user_agent => 'Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.6; en-US; rv:1.9.1.9) Gecko/20100315 Firefox/3.5.9'
      })
      Nokogiri::XML(response.body)
    end
    
    def url(path)
      base + path
    end
  end
end