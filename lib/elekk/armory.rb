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

    def character(name, realm=@realm)
      Character.new name, realm, :region => @region, :armory => self
    end

    def base
      "http://#{@region}.wowarmory.com/"
    end

    def get_xml(resource, params=nil)
      resource+= '.xml' unless resource =~ /\./
      response = HTTP.xml(url(resource), params, {
        :cache_timeout => 24*3600,
        :user_agent => 'Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.6; en-US; rv:1.9.1.9) Gecko/20100315 Firefox/3.5.9'
      })
    end
    
    def get_feed(characters, realm=nil)
      characters = [characters] unless characters.is_a? Array
      feed_xml = get_xml 'character-feed.atom', :r => (realm || @realm), :cn => characters.sort.join(',')
      feed = feed_xml.css('entry').collect do |c|
        item = { :title => c.at_css('title').content,
          :id => c.at_css('id').content,
          :link => c.at_css('link').content,
          :time => Time.parse(c.at_css('published').content),
          :content => c.at_css('content').content
        }
        item[:character] = $1 if item[:title] =~ /(\w+)/
        if item[:title] =~ /\[((.*)\s+\w+\s*\(([^(]+)\))\]\s+\d+\s+times/
          item[:collator] = $1
          item[:boss] = $2
          item[:instance] = $3
          item[:type] = :boss
        end
        if item[:content] =~ /<a href=.*#ach(\d+)">([^<]*)<\/a>/
          item[:achievement_id] = $1
          item[:achievement_name] = $2
          item[:collator] = $2
          if item[:title] =~ /step \[([^\]]*)\]/
            item[:type] = :step
            item[:collator] = item[:achievement_name] + " - " + $1
            item[:step] = $1
          else
            item[:type] = :achievement
          end
        end
        if item[:content] =~ /item-info\.xml\?i=(\d+).*\[(.*)\]/
          item[:item_id] = $1
          item[:item_name] = $2
          item[:collator] = $2
          item[:type] = :item
        end
        item[:coll_id] = [item[:type], item[:collator], item[:time]].hash
        item
      end
    end
    
    def get_feeds(characters, realm=nil)
      # split characters into least set of batches of no more than 5,
      # no less than 2
      
      batches = characters.sort / 5
      if batches.last.length < 2
        batches.last.unshift batches[batches.length - 2].pop
      end
      
      feeds = []
      batches.collect {|chars|
        feeds += get_feed chars, realm
      }
      feeds.sort {|a,b| b[:time] <=> a[:time]}
    end
    
    def collate_feeds(feeds)
      coll = {}
      feeds.each do |e|
        coll[e[:coll_id]] ||= e
        coll[e[:coll_id]] << e
      end
      coll
    end
    
    def search(query, type=:all)
      xml = get_xml('search', :searchQuery => query, :searchType => type.to_s)
    end
    
    def self.icon_url(icon)
      url "wow-icons/_images/51x51/#{icon}.jpg"
    end
    
    def url(path)
      base + path
    end
  end
end

class Array
  def / len
    a = []
    each_with_index do |x,i|
      a << [] if i % len == 0
      a.last << x
    end
    a
  end
end
