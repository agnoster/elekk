require 'rubygems'
require 'rake'
require 'spec/rake/spectask'

desc "Run all tests"
Spec::Rake::SpecTask.new('spec') do |t|
	t.spec_files = FileList['spec/**/*.rb']
	t.spec_opts = ["--color", "--format", "specdoc"]
	t.fail_on_error = false
end
