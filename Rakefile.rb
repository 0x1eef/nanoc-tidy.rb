require "rake/testtask"

desc "Run CI tasks"
task :ci do
  sh "rake test"
  sh "bundle exec rubocop"
end

Rake::TestTask.new do |t|
  t.test_files = FileList['test/*_test.rb']
  t.verbose = true
  t.warning = false
end
task default: :test
