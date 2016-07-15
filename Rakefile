require 'rspec/core/rake_task'
require 'rubocop/rake_task'
require 'foodcritic'
require 'kitchen'

task default: :ci_merge

namespace :syntax do
  desc "Check whether cookbook contains ruby syntax errors in .rb and .erb files"
  task :knife_syntax do
    puts "Running knife cookbook test ... "
    sh "knife cookbook test -a -o ."
    puts "knife cookbook test FINISHED."
  end
end
desc "Run all syntax tests"
task :syntax do
  Rake.application.in_namespace(:syntax){|x| x.tasks.each{|t| t.invoke}}
end

namespace :style do
  FoodCritic::Rake::LintTask.new do |t|
    t.options = {:fail_tags => ['correctness']}
  end
end
desc "Run all style tests"
task :style do
  Rake.application.in_namespace(:style){|x| x.tasks.each{|t| t.invoke}}
end

namespace :unit do
  desc "Run rspec and chefspec tests"
  RSpec::Core::RakeTask.new do |t|
    t.pattern = "spec/**/*_spec.rb"
  end
end
desc "Run all unit tests"
task :unit do
  Rake.application.in_namespace(:unit){|x| x.tasks.each{|t| t.invoke}}
end

begin
  require 'kitchen/rake_tasks'
  Kitchen::RakeTasks.new
end
desc "Run kitchen openstack test(s)"
task :integration do
  Rake.application.in_namespace(:kitchen) do |x|
    x.tasks.each do |t|
      if t.name.include? "openstack"
        t.invoke
      end
    end
  end
end

desc "Run all tests except rubocop"
task :ci_merge do
  Rake::Task['syntax'].invoke
  Rake::Task['style:foodcritic'].invoke
  Rake::Task['unit'].invoke
  Rake::Task['integration'].invoke
end
