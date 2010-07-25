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
    
    def achievements(category)
      category = AchievementCategory[category]
      @achievements ||= {}
      @achievements[category.to_sym] ||=
        xml(:achievements, :c => category.to_i).css('achievement').map {|x| Achievement.from_xml x}
      
    end
    
    def xml(resource, opts={})
      opts = {:r => @realm, :cn => @name}.merge opts
      self.armory.get_xml "character-#{resource}", opts
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
    
    def points
      @properties[:points] ||= sheet.at_css('character')['points'].to_i
    end
    
    def feed
      self.armory.get_feed @name, @realm
    end
    
    def spec(which)
      if not @properties[:specs]
        specs = {}
        primary = 0
        sheet.css('talentSpecs talentSpec').each do |t|
          n = t['group'].to_i-1
          specs[n] = TalentTree.const_get(klass.to_sym)[t['prim'].to_s]
          specs[:active] = specs[n] if t['active']
        end
        @properties[:specs] = specs
      end
      @properties[:specs][which]
    end
    
    def portrait
      type = 'default'
      [60, 70, 80].each { |m| type = m if level >= m }
      
      self.armory.url "_images/portraits/wow-#{type}/#{gender.id}-#{race.id}-#{klass.id}.gif"
    end
    
    def fullname(tag=nil)
      n = name
      n = "<#{tag}>#{n}</#{tag}>" if tag unless tag == ''
      sheet.at_css('character')['prefix'] + n + sheet.at_css('character')['suffix']
    end
  end
end