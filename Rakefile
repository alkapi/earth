require 'rubygems'

def require_or_fail(gems, message, failure_results_in_death = false)
  gems = [gems] unless gems.is_a?(Array)

  begin
    gems.each { |gem| require gem }
    yield
  rescue LoadError
    puts message
    exit if failure_results_in_death
  end
end

unless ENV['NOBUNDLE']
  message = <<-MESSAGE
In order to run tests, you must:
  * `gem install bundler`
  * `bundle install`
  MESSAGE
  require_or_fail('bundler',message,true) do
    Bundler.setup
  end
end

require 'rake/rdoctask'

require_or_fail('jeweler', 'Jeweler (or a dependency) not available. Install it with: gem install jeweler') do
  Jeweler::Tasks.new do |gem|
    gem.name = "earth"
    gem.summary = %Q{Land, sky, and sea}
    gem.description = %Q{An earth-simulation environment with ActiveRecord models and data}
    gem.email = 'andy@rossmeissl.net'
    gem.homepage = 'http://github.com/brighterplanet/earth'
    gem.authors = ['Seamus Abshere', 'Derek Kastner', "Andy Rossmeissl"]
    gem.files = ['LICENSE', 'README.markdown'] + 
      Dir.glob(File.join('lib', '**','*.rb')) +
      Dir.glob(File.join('vendor', '**','*')) - 
      ['.gitignore','Gemfile','Gemfile.lock']
    gem.test_files = Dir.glob(File.join('features', '**', '*.rb')) +
      Dir.glob(File.join('spec', '**', '*.rb')) +
      Dir.glob(File.join('lib', 'test_support', '**/*.rb')) +
      ['Gemfile','Gemfile.lock']
    gem.add_dependency 'activerecord', '>=3.0.0.beta4'
    gem.add_dependency 'data_miner', '~>0.5.6' unless ENV['LOCAL_DATA_MINER']
    gem.add_dependency 'falls_back_on', '>=0.0.3'
    gem.add_dependency 'geokit', '>=1.5.0'
    gem.add_dependency 'cohort_scope', '>=0.0.7'
    gem.add_dependency 'conversions', '>=1.4.5'
    gem.add_dependency 'weighted_average', '>=0.0.4'
    gem.add_dependency 'loose_tight_dictionary', '>=0.0.8'
    gem.add_development_dependency 'rspec', '>=2.0.0.beta.17'
    gem.add_development_dependency 'rake'
    gem.add_development_dependency 'jeweler', '1.5.0'
    gem.add_development_dependency 'rcov'
    gem.add_development_dependency 'rdoc'
    gem.add_development_dependency 'sqlite3-ruby', '>=1.3.0'
  end
  Jeweler::GemcutterTasks.new
end

require_or_fail('rcov', 'RSpec gem not found, RSpec tasks unavailable') do
  require 'rcov/rcovtask'
  Rcov::RcovTask.new do |test|
    test.libs << 'spec'
    test.pattern = 'spec/**/*.rb'
    test.verbose = true
  end
end

require_or_fail('rspec', 'RSpec gem not found, RSpec tasks unavailable') do
  require 'rspec/core/rake_task'

  desc "Run all examples"
  RSpec::Core::RakeTask.new('examples')

  task :default => :examples
  task :test => :examples
end

Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "earth #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
