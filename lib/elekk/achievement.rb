module Elekk
  class Achievement
    attr_accessor :id, :title, :points, :icon, :description, :category, :completed
    
    def initialize(id, opts={})
      @id = id
      @title = opts[:title]
      @points = opts[:points]
      @icon = opts[:icon]
      @description = opts[:description]
      @category = AchievementCategory[opts[:category]]
      @completed = opts[:completed]
    end
    
    def self.from_xml(node)
      a = self.new(node['id'].to_i, {
        :title => node['title'].to_s,
        :points => node['points'].to_i,
        :icon => node['icon'].to_s,
        :description => node['description'].to_s,
        :category => node['categoryId'].to_i
      })
      a.completed = Time.parse(node['dateCompleted'].to_s) if node['dateCompleted']
      a
    end
    
    def complete?
      return !!completed
    end
    
    def wowhead
      Wowhead::Result.new(@id, @title, Wowhead::Kind['Achievement'], @icon)
    end
  end
  
  class AchievementCategory < Enum
    add_item 'General', 92
    add_item 'Quests', 96
    add_item 'Exploration', 97
    add_item 'Player vs. Player', 95
    add_item 'Dungeons & Raids', 168
    add_item 'Professions', 169
    add_item 'Reputation', 201
    add_item 'World Events', 155
    add_item 'Feats of Strength', 81
    
    add_obj  AchievementCategory::DungeonsRaids, :Raid
    add_obj  AchievementCategory::PlayervsPlayer, :PvP
    add_obj  AchievementCategory::Reputation, :Rep
  end
end