require 'json'

module Elekk
  class Wowhead
    def self.search(term)
      response = HTTP.request('http://www.wowhead.com/search', {:q => term, :opensearch => nil}, :cache_timeout => 60)
      resp = JSON.parse(response.body)
      data = []
      resp[1].each_with_index do |v,i|
        d = resp[7][i]
        kind = Kind[d[0]]
        data.push Result.new d[1], v.gsub(/\s*\(#{kind}\)$/, ''), kind, d[2], d[3]
      end
      data
    end
    
    class Result
      attr_reader :name, :id, :kind, :icon, :quality
      
      def initialize(id, name, kind, icon=nil, quality=nil)
        @id = id
        @name = name
        @kind = kind
        @icon = icon
        @quality = Quality[quality] if quality
      end
      
      def to_s
        @name
      end
      
      def to_html
        q = (@kind == Kind::Item) ? " class='q#{@quality.to_i}'" : ''
        "<a href='#{url}'#{q}>#{@name}</a>"
      end
      
      def url
        "http://www.wowhead.com/#{@kind.to_s.downcase}=#{@id}"
      end
      
      def icon_url(size=:medium) # :small, :medium, or :large
        "http://static.wowhead.com/images/wow/icons/#{size}/#{icon}.jpg" if icon
      end
      
      def self.from_html(mkp)
        html = Nokogiri.HTML(mkp)
        link = html.at_css('a')
        return unless link
        if link['href'] =~ /wowhead.com\/(\w+)\=(\d+)/
          id = $2
          kind = Kind.find(/^#{$1}$/i)
          quality = $1.to_i if kind == Kind::Item and link['class'] =~ /q(\d)/
        end
        name = link.content
        Result.new id, name, kind, nil, quality
      end
    end
  end
end