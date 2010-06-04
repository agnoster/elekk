require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |s|
    s.name = "elekk"
    s.summary = "A simple library for World of Warcraft data in Ruby."
    s.email = "agnoster@gmail.com"
    s.homepage = "http://github.com/agnoster/elekk"
    s.description = "A simple library for World of Warcraft data in Ruby."
    s.authors = ["Isaac Wasileski"]
    s.files =  FileList["*", "{lib,spec}/**/*"]
    s.add_dependency 'typhoeus'
    s.add_dependency 'memcached'
    s.add_dependency 'nokogiri'
    s.add_dependency 'json'
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler, or one of its dependencies, is not available. Install it with: sudo gem install technicalpickles-jeweler -s http://gems.github.com"
end

begin
  require 'spec/rake/spectask'
  desc "Run all tests"
  Spec::Rake::SpecTask.new('spec') do |t|
    t.spec_files = FileList['spec/**/*.rb']
    t.spec_opts = ["--color", "--format", "specdoc"]
    t.fail_on_error = false
  end
rescue LoadError
  puts "No rspec installed, can't run tests"
end