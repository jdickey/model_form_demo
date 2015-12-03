# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

if %w(development test).include? Rails.env
  require 'rake/testtask'

  require 'rake/tasklib'
  require 'flay_task'
  require 'flog'
  require 'flog_task'
  require 'reek/rake/task'
  require 'rubocop/rake_task'

  Rake::TestTask.new(:test) do |t|
    t.libs << 'app'
    t.libs << 'lib'
    t.libs << 'test'
    t.test_files = FileList['test/**/*_test.rb']
  end

  RuboCop::RakeTask.new(:rubocop) do |task|
    task.patterns = [
      'app/**/*.rb',
      'test/**/*.rb'
    ]
    task.formatters = ['simple', 'd']
    task.fail_on_error = true
    task.options << '--rails'
    task.options << '--display-cop-names'
  end

  Reek::Rake::Task.new do |t|
    t.config_file = 'config/config.reek'
    t.source_files = '{app,lib,test}/**/*.rb'
    t.reek_opts = '--sort-by smelliness -s'
  end

  FlayTask.new do |t|
    t.verbose = true
    t.dirs = %w(app lib)
  end

  FlogTask.new do |t|
    t.verbose = true
    t.threshold = 300 # default is 200
    t.instance_variable_set :@methods_only, true
    t.dirs = %w(app lib) # Look, Ma! No tests! (Run for `test` periodically.)
  end

  task(:default).clear
  task default: [:test, :rubocop, :flay, :flog, :reek]
end

# This auto-generated line will cause tests to be run *twice*. Why TF this is,
# I have no idea. Enlighten me.
Rails.application.load_tasks
