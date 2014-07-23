require 'rake/testtask'

Rake::TestTask.new do |t|
  t.libs << 'spec'
  t.test_files = FileList['spec/test*.rb']
  t.verbose = true
end

desc "Run tests"
task :default => :test
