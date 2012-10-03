Elekk
=====

> **STATUS: Defunct** — Elekk worked with the old version of the armory, and will no longer function with the new one. The code here is for historical purposes only, because I don't like hiding from bad code I wrote in the past :-)
>
> If you're interested in taking the project over in any way, please [email](mailto:i@agnoster.net) or [twitter](http://twitter.com/agnoster) me. In all honesty though, you're probably better off starting from scratch!

[Elekk] is a Ruby gem that provides an interface to data for Blizzard's highly popular MMORPG, World of Warcraft. It currently uses data both from Blizzard's official [Armory] website, as well as the popular community database, [Wowhead]. Future versions may make use of additional sources of information.

Goals
-----

 * Make querying information as natural and simple as possible
 * Have native representations of every data type
 * Reflect actual identifiers/schemes as closely as possible

Features
--------

 * Get basic character information from the Armory
	  * Class
	  * Level
	  * Faction
	  * Race
	  * Gender
	  * Achievement Points
	  * Title
	  * Armory portrait
 * Search on Wowhead with a simple text query and get
	  * Internal identifiers for results
	  * Links back to Wowhead
	  * Icons (when available)
	  * Quality (for items)
 * Query achievements
	  * Get internal identifiers, icons, title and description
	  * Get the date the character completed the achievement
	  * Should support all categories now

To see how all this is done, it's probably best to check the [`spec/`][specs] directory, which has exhaustive examples of how to use nearly all the APIs, and is likely to be kept more up-to-date than this readme.

Example
-------

	>> a = Armory.new 'Uldaman', :us
	=> #<Elekk::Armory:0x10168cf20 @region=:us, @realm="Uldaman">
	>> fyrbard = a.character 'Fyrbard'
	=> #<Elekk::Character:0x101687818 @name="Fyrbard", @properties={:realm=>"Uldaman", :region=>:us, :name=>"Fyrbard"}, @armory=#<Elekk::Armory:0x10168cf20 @region=:us, @realm="Uldaman">, @region=:us, @realm="Uldaman">
	>> puts fyrbard.race, fyrbard.race.to_i; fyrbard.race.to_sym
	Dwarf
	3
	=> :Dwarf
	>> fyrbard.level
	=> 80
	>> fyrbard.points
	=> 4505
	>> bitten = fyrbard.achievements(Achievements::Raid).find {|a| a.title =~ /once bitten/i}
	=> #<Elekk::Achievement:0x1013e1aa0 @category=#<Elekk::Achievements:0x1016a6308 @name="Raid", @symbol=:Raid, @id=168>, @points=10, @description="", @id=4539, @time=Wed May 19 08:34:00 +0200 2010, @title="Once Bitten, Twice Shy (10 player)", @icon="achievement_boss_lanathel">
	>> (Time.now - bitten.completed) / (3600*24)
	=> 17.1609193367708
	>> bitten.wowhead.icon_url(:large)
	=> "http://static.wowhead.com/images/wow/icons/large/achievement_boss_lanathel.jpg"
	>> results = Wowhead.search 'once bitten'
	=> [#<Elekk::Wowhead::Result:0x101298108 @name="Once Bitten, Twice Shy (10 player)", @id=4539, @kind=#<Elekk::Kind:0x10141eea0 @name="Achievement", @symbol=:Achievement, @id=10>, @icon="achievement_boss_lanathel">, #<Elekk::Wowhead::Result:0x101297460 @name="Once Bitten, Twice Shy (25 player)", @id=4618, @kind=#<Elekk::Kind:0x10141eea0 @name="Achievement", @symbol=:Achievement, @id=10>, @icon="achievement_boss_lanathel">]
	>> results.first.id == bitten.id
	=> true
	>> results.first.to_html
	=> "<a href='http://www.wowhead.com/achievement=4539'>Once Bitten, Twice Shy (10 player)</a>"

[Elekk]: http://github.com/agnoster/elekk "Elekk on github"
[specs]: http://github.com/agnoster/elekk/tree/master/spec/ "Elekk specs on github"
[Armory]: http://www.wowarmory.com/ "The World of Warcraft Armory online"
[Wowhead]: http://www.wowhead.com/ "Wowhead"
