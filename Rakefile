require 'rubygems'
require 'rake'
require 'yard'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "feeder"
    gem.summary = %Q{Feeder is a set of classes for pulling and translating feeds in to a format we expect.}
    gem.email = "jamie@boxedup.com"
    gem.homepage = "http://github.com/boxedup/feeder"
    gem.authors = ["Jamie van Dyke"]
    
    gem.add_dependency('activesupport')
    gem.add_dependency('ruby-xslt')
    gem.add_dependency('nokogiri')
  end

rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: sudo gem install jeweler"
end

require 'rake/testtask'
Rake::TestTask.new(:test) do |test|
  test.libs << 'lib' << 'test'
  test.pattern = 'test/**/*_test.rb'
  test.verbose = true
end

begin
  require 'rcov/rcovtask'
  Rcov::RcovTask.new do |test|
    test.libs << 'test'
    test.pattern = 'test/**/*_test.rb'
    test.verbose = true
  end
rescue LoadError
  task :rcov do
    abort "RCov is not available. In order to run rcov, you must: sudo gem install spicycode-rcov"
  end
end


task :default => :test

YARD::Rake::YardocTask.new do |t|
  t.files   = ['lib/**/*.rb']
  t.options = []
end