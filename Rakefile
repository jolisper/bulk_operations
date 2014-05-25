require "bundler/gem_tasks"
require 'rake/testtask'

task :default => [:spec]

Rake::TestTask.new(:spec) do |t|
  t.libs.push "lib"
  t.test_files = FileList['spec/*_spec.rb']
end
