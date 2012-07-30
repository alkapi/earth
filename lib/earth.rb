require 'active_support/core_ext'
require 'active_support/string_inquirer'
require 'active_record'
require 'data_miner'
require 'weighted_average'
require 'fixed_width'
require 'errata'
require 'fuzzy_match'

require 'earth/conversions_ext'
require 'earth/inflectors'
require 'earth/loader'
require 'earth/model'
require 'earth/utils'
require 'earth/warnings'

# The earth module is an interface for loading data models
module Earth
  VENDOR_DIR = ::File.expand_path '../../vendor', __FILE__
  LIB_DIR = ::File.expand_path '../earth', __FILE__
  DATA_DIR = ::File.expand_path '../../data', __FILE__
  ERRATA_DIR = ::File.expand_path '../../errata', __FILE__

  mattr_accessor :mine_original_sources
  mattr_accessor :skip_parent_associations

  # Earth.init is the gateway to using Earth. It 
  # domains, any needed ActiveRecord plugins, and will apply each domain
  # model's schema to the database if the :apply_schemas option is given.
  # (See .domains for the list of allowable domains and an explanation
  # of what a domain is)
  #
  # Earth.init should be performed before any domain models are utilized.
  #
  # @param [Symbol] domain domain to load, e.g. `:all` (optional, deprecated)
  # @param [Hash] options load options
  # * :skip_parent_associations, if true, will not run data_miner on parent associations of a model. For instance, `Airport.run_data_miner!` will not data mine ZipCode, to which it belongs.
  # * :mine_original_sources, if true, will load files necessary to data mine from scratch rather than via taps
  # * :connect will connect to the database for you
  def Earth.init(*args)
    options = args.extract_options!

    connect if options[:connect]

    Warnings.check_mysql_ansi_mode
    
    if args.include? :all
      require 'earth/all'
    elsif args.length > 0
      Kernel.warn "Deprecation Warning: `Earth.init :domain` will be removed. Use `require 'earth/domain'` instead"
      args.each do |argh|
        require "earth/#{argh}"
      end
    end

    Earth.mine_original_sources = options[:load_data_miner] || options[:mine_original_sources]
    Earth.skip_parent_associations = options[:skip_parent_associations]
  end
  
  # List the currently loaded data model class names.
  #
  # @return [Array] a list of camelized resource names
  def Earth.resources
    Earth.resource_models.map(&:to_s).sort
  end

  def Earth.resource_models
    Earth::Model.registry
  end

  # Connect to the database according to current configurations in
  # Earth.database_configurations and the current environment in Earth.env.
  def Earth.connect
    ActiveRecord::Base.establish_connection Earth.database_configurations[Earth.env]
  end

  # The current environment. Earth detects the following environment variables:
  #
  # * EARTH_ENV (for CLI apps and daemons)
  # * RAILS_ENV
  # * RACK_ENV
  #
  # Default is `development`
  def Earth.env
    @env ||= ActiveSupport::StringInquirer.new(ENV['EARTH_ENV'] || ENV['RAILS_ENV'] || ENV['RACK_ENV'] ||'development')
  end

  # Earth will load database connection parameters from 
  # config/database.yml (same as Rails' database configuration).
  # Otherwise, a default testing configuration is used.
  def Earth.database_configurations
    yaml_path = File.join(Dir.pwd, 'config/database.yml')
    if File.exist?(yaml_path)
      require 'yaml'
      YAML.load_file yaml_path
    else
      case ENV['EARTH_DB_ADAPTER']
      when 'mysql'
        adapter = 'mysql2'
        database = 'test_earth'
        username = 'root'
        password = 'password'
      else
        adapter = 'postgresql'
        database = 'test_earth'
        username = nil
        password = nil
      end

      config = {
        'test' => {
          'encoding' => 'utf8',
          'adapter' => adapter,
          'database' => database,
        }
      }

      config['username'] = username if username
      config['password'] = password if password

      config
    end
  end

  # Drop and recreate tables for all currently loaded data models.
  #
  def Earth.reset_schemas!
    Earth.resource_models.map(&:create_table!)
  end

  # Run data miner on all currently loaded data models.
  #
  # @note By default, data is mined from data.brighterplanet.com 
  # via taps. In order to mine from scratch, call Earth.init 
  # with the :load_data_miner option.
  def Earth.run_data_miner!
    Earth.resource_models.map(&:run_data_miner!)
  end
end
