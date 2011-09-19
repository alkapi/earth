class AutomobileMakeModelYearVariant < ActiveRecord::Base
  set_primary_key :row_hash
  
  belongs_to :make,            :class_name => 'AutomobileMake',          :foreign_key => 'make_name'
  belongs_to :make_model,      :class_name => 'AutomobileMakeModel',     :foreign_key => 'make_model_name'
  belongs_to :make_model_year, :class_name => 'AutomobileMakeModelYear', :foreign_key => 'make_model_year_name'
  belongs_to :fuel,            :class_name => 'AutomobileFuel',          :foreign_key => 'fuel_code', :primary_key => 'code'
  
  col :row_hash
  col :name # short name!
  col :make_name
  col :make_model_name # make + model
  col :make_year_name # make + year
  col :make_model_year_name # make + model + year
  col :year, :type => :integer
  col :fuel_efficiency, :type => :float
  col :fuel_efficiency_units
  col :fuel_efficiency_city, :type => :float
  col :fuel_efficiency_city_units
  col :fuel_efficiency_highway, :type => :float
  col :fuel_efficiency_highway_units
  col :fuel_code
  col :transmission
  col :drive
  col :turbo, :type => :boolean
  col :supercharger, :type => :boolean
  col :cylinders, :type => :integer
  col :displacement, :type => :float
  col :raw_fuel_efficiency_city, :type => :float
  col :raw_fuel_efficiency_city_units
  col :raw_fuel_efficiency_highway, :type => :float
  col :raw_fuel_efficiency_highway_units
  col :carline_mfr_code, :type => :integer
  col :vi_mfr_code, :type => :integer
  col :carline_code, :type => :integer
  col :carline_class_code, :type => :integer
  col :injection, :type => :boolean
  col :carline_class_name
  col :speeds
  add_index :make_name
  add_index :make_model_name
  add_index :make_year_name
  add_index :make_model_year_name
end