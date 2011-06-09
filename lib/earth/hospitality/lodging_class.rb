class LodgingClass < ActiveRecord::Base
  set_primary_key :name
  
  create_table do
    string 'name'
    float  'electricity_intensity'
    string 'electricity_intensity'
    float  'natural_gas_intensity'
    string 'natural_gas_intensity'
    float  'fuel_oil_intensity'
    string 'fuel_oil_intensity'
    float  'district_heat_intensity'
    string 'district_heat_intensity'

    string 'natural_gas_intensity_units'
    string 'fuel_oil_intensity_units'
    string 'electricity_intensity_units'
    string 'district_heat_intensity_units'
  end
end
