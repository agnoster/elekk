require 'rubygems'
require 'rake'
require 'spec/rake/spectask'
require 'echoe'

Echoe.new('elekk') do |p|
  p.summary    = "A simple library for World of Warcraft data in Ruby."
  p.description = "Koala is a lightweight, flexible Ruby SDK for Facebook.  It allows read/write access to the social graph via the Graph API and the older REST API, as well as support for realtime updates and OAuth and Facebook Connect authentication.  Koala is fully tested and supports Net::HTTP and Typhoeus connections out of the box and can accept custom modules for other services."
  p.url            = "http://github.com/agnoster/elekk"
  p.author         = "Isaac Wasileski"
  p.email          = "agnoster@gmail.com"
  p.ignore_pattern = ["tmp/*", "script/*", "pkg/*"]
  p.development_dependencies = ['rspec']
  p.runtime_dependencies = ['typhoeus', 'memcached', 'nokogiri', 'json']
end
  

desc "Run all tests"
Spec::Rake::SpecTask.new('spec') do |t|
  t.spec_files = FileList['spec/**/*.rb']
  t.spec_opts = ["--color", "--format", "specdoc"]
  t.fail_on_error = false
end