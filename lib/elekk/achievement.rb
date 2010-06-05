module Elekk
  class Achievement
    attr_accessor :id, :title, :points, :icon, :description, :category, :completed
    
    def initialize(id, opts={})
      @id = id
      @title = opts[:title]
      @points = opts[:points]
      @icon = opts[:icon]
      @description = opts[:description]
      @category = opts[:category]
      @completed = opts[:completed]
    end
    
    def self.from_xml(node)
      a = self.new(node['id'].to_i, {
        :title => node['title'].to_s,
        :points => node['points'].to_i,
        :icon => node['icon'].to_s,
        :description => node['description'].to_s,
        :category => Achievements[node['categoryId'].to_i]
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
  
  class Achievements < Enum
    add_item 'Raid', 168
  end
end