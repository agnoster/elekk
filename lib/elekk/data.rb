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
        yield v unless v.nil?
      end
    end
    
    def self.find(cond=nil, &block)
      each do |v|
        if cond and not cond === v.to_s
          next
        end
        if block and not yield v
          next
        end
        return v
      end
      return nil
    end
    
    def to_s
      @name
    end
    
    def to_i
      @id
    end
  end
  
  class Klass < Enum
    self.add_items nil, "Warrior", "Paladin", "Hunter", "Rogue", "Priest",
                  "Death Knight", "Shaman", "Mage", "Warlock", nil, "Druid"
  end
  
  class Faction < Enum
    self.add_items 'Alliance', 'Horde'
  end
  
  class Race < Enum
    self.add_items nil, 'Human', 'Orc', 'Dwarf', 'Night Elf', 'Undead',
                   'Tauren', 'Gnome', 'Troll', nil, 'Blood Elf', 'Draenei'
  end
  
  class Gender < Enum
    self.add_items 'Male', 'Female'
  end
  
  class Quality < Enum
    self.add_items 'Poor', 'Common', 'Uncommon', 'Rare', 'Epic', 'Legendary', 'Artifact', 'Heirloom'
  end
  
  class Kind < Enum
    self.add_items nil, 'NPC', 'Object', 'Item', 'Item Set', 'Quest', 'Spell',
      'Zone', 'Faction', 'Pet', 'Achievement'
    self.add_items 'Class', 'Race', 'Skill', 13
  end
  
  module TalentTree
    class Priest < Enum
      self.add_items 'Discipline', 'Holy', 'Shadow'
    end
    class Warrior < Enum
      self.add_items 'Arms', 'Fury', 'Protection'
    end
    class Shaman < Enum
      self.add_items 'Elemental', 'Enhancement', 'Restoration'
    end
    class Druid < Enum
      self.add_items 'Balance', 'Feral', 'Restoration'
    end
    class Paladin < Enum
      self.add_items 'Holy', 'Protection', 'Retribution'
    end
    class Mage < Enum
      self.add_items 'Arcane', 'Fire', 'Frost'
    end
    class Warlock < Enum
      self.add_items 'Affliction', 'Demonology', 'Destruction'
    end
    class DeathKnight < Enum
      self.add_items 'Blood', 'Frost', 'Unholy'
    end
    class Hunter < Enum
      self.add_items 'Beast Mastery', 'Marksmanship', 'Survival'
    end
    class Rogue < Enum
      self.add_items 'Assassination', 'Combat', 'Subtlety'
    end
  end
end
