module Elekk
  class Character
    attr_reader :name, :realm, :region
    attr_writer :armory
    
    def initialize(name, realm, opts={})
      @name = name
      @realm = realm
      @region = opts[:region] || Elekk::default_region
      @armory = opts[:armory]
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
    
  end
end