require 'rake'
require 'rake-version'
require 'rspec/core/rake_task'

#task :spec    => ['spec:all']
task :default => [:spec]

RakeVersion::Tasks.new do |v|
  v.copy 'semi.gemspec'
  v.copy 'lib/semi/version.rb'
end

desc 'Run the spec tests.'
RSpec::Core::RakeTask.new do |t|
  t.pattern = 'spec/**/*_spec.rb'
end