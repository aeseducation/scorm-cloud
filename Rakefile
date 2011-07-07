require 'bundler'
require 'rspec/core/rake_task'
require 'cucumber/rake/task'

Bundler::GemHelper.install_tasks
RSpec::Core::RakeTask.new('spec')

Cucumber::Rake::Task.new do |t|
  t.cucumber_opts = "--tags ~@apibug"
end

namespace :cucumber do
	Cucumber::Rake::Task.new('apibugs') do |t|
  	t.cucumber_opts = "--tags @apibug"
	end
	Cucumber::Rake::Task.new('wip') do |t|
  	t.cucumber_opts = "--tags @wip"
	end
end

task :test do
	[:spec, :cucumber].each { |t| Rake::Task[t].execute }
end

task :default => :test