# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "elekk/version"

Gem::Specification.new do |s|
  s.name        = "elekk"
  s.version     = Elekk::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Isaac Wolkerstorfer"]
  s.email       = ["i@agnoster.net"]
  s.homepage    = "https://github.com/agnoster/elekk"
  s.summary     = %q{[OUTDATED] Ruby interface for World of Warcraft data}
  s.description = %q{WARNING: Outdated and non-functional!

  					Elekk is a Ruby gem that provides an interface to data for Blizzard's highly popular
  					MMORPG, World of Warcraft. It currently uses data both from Blizzard's official Armory website
  					at wowarmory.com, as well as the popular community database, WoWhead.com. Future versions may
  					make use of additional sources of information.}

  s.rubyforge_project = "elekk"

  s.post_install_message = "Elekk is deprecated. The format of the Armory API has changed, and there are currenty no plans to update the gem."

  s.add_dependency 'nokogiri'
  s.add_dependency 'json'
  s.add_dependency 'typhoeus'
  s.add_dependency 'memcached'

  s.add_development_dependency 'rake'
  s.add_development_dependency 'rspec'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
