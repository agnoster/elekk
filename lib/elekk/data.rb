module Elekk
  class Enum
    attr_accessor :name, :id
    
    def initialize(name, id)
      @name = name
      @id = id
    end
    
    def to_sym
      @symbol ||= @name.gsub(/\W/,'').to_sym
    end    
    
    def self.const_missing(name)
      @hash[name]
    end
    
    def self.[](idx)
      if idx.is_a? Integer
        @array[idx]
      elsif idx.is_a? String
        @hash[idx.gsub(/\W/,'').to_sym]
      elsif idx.is_a? Symbol
        @hash[idx]
      else
        nil
      end
    end
    
    def self.add_item(name, id=nil?)
      @hash ||= {}
      @array ||= []
      id ||= @array.length
      if name.nil?
        @array[id] = nil
      else
        k = self.new(name,id)
        @array[id] = k
        @hash[k.to_sym] = k
      end
    end
    
    def self.add_items(*arr)
      start = arr.pop if arr.last.is_a? Integer
      arr.each do |a|
        self.add_item a, start
        start = nil
      end
    end
    
    def self.each
      @array.each do |v|
        yield v
      end
    end
    
    def to_s
      @name
    end
    
    def to_i
      @id
    end
  end
  
  class Klass < Enum
    self.add_items "Warrior", "Paladin", "Hunter", "Rogue", "Priest",
                  "Death Knight", "Shaman", "Mage", "Warlock", nil, "Druid", 1
  end
  
  class Faction < Enum
    self.add_items 'Alliance', 'Horde'
  end
  
  class Race < Enum
    self.add_items 'Human', 'Orc', 'Dwarf', 'Night Elf', 'Undead',
                   'Tauren', 'Gnome', 'Troll', nil, 'Blood Elf', 'Draenei', 1
  end
  
  class Gender < Enum
    self.add_items 'Male', 'Female'
  end
end
