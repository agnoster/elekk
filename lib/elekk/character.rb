module Elekk
  class Character
    attr_reader :name, :realm, :region
    attr_writer :armory
    attr_reader :properties
    
    def initialize(name, realm, opts={})
      @name = name
      @realm = realm
      @region = opts[:region] || Elekk::default_region
      @armory = opts[:armory]
      @properties = { :name => @name, :realm => @realm, :region => @region }
    end
    
    def armory
      @armory ||= Armory.new @realm, :region => @region
    end
    
    def sheet
      @sheet ||= xml :sheet
    end
    
    def xml(resource)
      self.armory.get_xml "character-#{resource}", :r => @realm, :cn => @name
    end
    
    def klass
      @properties[:klass] ||= Klass[sheet.at_css('character')['classId'].to_i]
    end
    
    def faction
      @properties[:faction] ||= Faction[sheet.at_css('character')['factionId'].to_i]
    end
    
    def race
      @properties[:race] ||= Race[sheet.at_css('character')['raceId'].to_i]
    end
    
    def level
      @properties[:level] ||= sheet.at_css('character')['level'].to_i
    end
    
    def gender
      @properties[:gender] ||= Gender[sheet.at_css('character')['genderId'].to_i]
    end
    
    def portrait
      type = 'default'
      [60, 70, 80].each { |m| type = m if level >= m }
      
      @armory.url "_images/portraits/wow-#{type}/#{gender.id}-#{race.id}-#{klass.id}.gif"
    end
    
    def fullname(tag=nil)
      n = name
      n = "<#{tag}>#{n}</#{tag}>" if tag unless tag == ''
      sheet.at_css('character')['prefix'] + n + sheet.at_css('character')['suffix']
    end
  end
end