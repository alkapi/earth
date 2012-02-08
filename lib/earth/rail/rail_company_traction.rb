require 'earth/fuel'
class RailCompanyTraction < ActiveRecord::Base
  self.primary_key = :name
  col :name
  col :rail_company_name
  col :rail_traction_name
  col :electricity_intensity, :type => :float
  col :electricity_intensity_units
  col :diesel_intensity, :type => :float
  col :diesel_intensity_units
  col :co2_emission_factor, :type => :float
  col :co2_emission_factor_units
end
