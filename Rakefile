require "bundler/gem_tasks"

require "rake/testtask"

Rake::TestTask.new do |t|
  t.test_files = FileList['test/*_test.rb', 'test/test_helper']
end

task default: :test
