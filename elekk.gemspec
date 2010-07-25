# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run the gemspec command
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{elekk}
  s.version = "1.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Isaac Wolkerstorfer"]
  s.date = %q{2010-07-25}
  s.description = %q{A simple library for World of Warcraft data in Ruby.}
  s.email = %q{agnoster@gmail.com}
  s.files = [
    "Manifest",
     "Rakefile",
     "VERSION",
     "changelog.md",
     "elekk.gemspec",
     "lib/elekk.rb",
     "lib/elekk/achievement.rb",
     "lib/elekk/armory.rb",
     "lib/elekk/character.rb",
     "lib/elekk/data.rb",
     "lib/elekk/http.rb",
     "lib/elekk/wowhead.rb",
     "readme.md",
     "spec/achievement_spec.rb",
     "spec/armory_spec.rb",
     "spec/character_spec.rb",
     "spec/klass_spec.rb",
     "spec/test.rb",
     "spec/wowhead_spec.rb"
  ]
  s.homepage = %q{http://github.com/agnoster/elekk}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{A simple library for World of Warcraft data in Ruby.}
  s.test_files = [
    "spec/achievement_spec.rb",
     "spec/armory_spec.rb",
     "spec/character_spec.rb",
     "spec/klass_spec.rb",
     "spec/test.rb",
     "spec/wowhead_spec.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<typhoeus>, [">= 0"])
      s.add_runtime_dependency(%q<memcached>, [">= 0"])
      s.add_runtime_dependency(%q<nokogiri>, [">= 0"])
      s.add_runtime_dependency(%q<json>, [">= 0"])
    else
      s.add_dependency(%q<typhoeus>, [">= 0"])
      s.add_dependency(%q<memcached>, [">= 0"])
      s.add_dependency(%q<nokogiri>, [">= 0"])
      s.add_dependency(%q<json>, [">= 0"])
    end
  else
    s.add_dependency(%q<typhoeus>, [">= 0"])
    s.add_dependency(%q<memcached>, [">= 0"])
    s.add_dependency(%q<nokogiri>, [">= 0"])
    s.add_dependency(%q<json>, [">= 0"])
  end
end

