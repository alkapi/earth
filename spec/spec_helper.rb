require 'rubygems'
require 'bundler'
Bundler.setup

require 'active_record'
require 'sqlite3'
ActiveRecord::Base.establish_connection :adapter => 'sqlite3',
  :database => ':memory:'

$:.unshift File.join(File.dirname(__FILE__), '..', 'lib')
require 'earth' # we do require Earth to live

RSpec.configure do |c|
  c.filter_run_excluding :slow => true
end
