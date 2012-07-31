require 'spec_helper'

describe Earth do
  describe '.init' do
    before :all do
      Earth.init :all
    end

    it 'should require all Earth models' do
      lambda do
        Earth.resource_names.each { |k| k.constantize }
      end.should_not raise_error(NameError)
    end

    it 'should include data_miner definitions' do
      lambda do
        Earth.resource_names.each { |k| k.constantize.should_receive(:data_miner) }
      end
      require 'earth/data_miner'
    end
  end

  describe '.resources' do
    it 'should get a list of all resource classes' do
      Earth.init :all
      Earth.resources.length.should == 100
      Earth.resources.should include(Aircraft)
      Earth.resources.should include(Industry)
    end
  end

  describe '.database_configurations' do
    it 'reads configuration from a yaml file' do
      require 'sandbox'
      require 'fileutils'
      Sandbox.play do |path|
        Dir.chdir path do
          FileUtils.mkdir 'config'
          File.open 'config/database.yml', 'w' do |f|
            f.puts <<-YML
  test:
    adapter: mysql
    database: just_a_test
            YML
          end

          Earth.database_configurations['test'].should == {
            'adapter' => 'mysql',
            'database' => 'just_a_test'
          }
        end
      end
    end
    it "defaults to Earth's test environment" do
      Earth.database_configurations['test']['database'].should == 'test_earth'
    end
  end
end
