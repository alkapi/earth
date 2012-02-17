require 'earth/locality'

class MecsEnergy < ActiveRecord::Base
  self.primary_key = "name"
  
  col :name
  col :census_region_number, :type => :integer
  col :naics_code
  col :energy, :type => :float
  col :energy_units
  col :electricity, :type => :float
  col :electricity_units
  col :residual_fuel_oil, :type => :float
  col :residual_fuel_oil_units
  col :distillate_fuel_oil, :type => :float
  col :distillate_fuel_oil_units
  col :natural_gas, :type => :float
  col :natural_gas_units
  col :lpg_and_ngl, :type => :float
  col :lpg_and_ngl_units
  col :coal, :type => :float
  col :coal_units
  col :coke_and_breeze, :type => :float
  col :coke_and_breeze_units
  col :other_fuel, :type => :float
  col :other_fuel_units
  
  FUELS = [:electricity, :residual_fuel_oil, :distillate_fuel_oil,
           :natural_gas, :lpg_and_ngl, :coal, :coke_and_breeze, :other_fuel]
  
   # Find the first record whose naics_code matches code.
   # If no record found chop off the last character of code and try again, and so on.
   def self.find_by_naics_code(code)
     find_by_naics_code_and_census_region_number(code, nil)
   end
   
  # Find the first record whose census_region_number matches number and whose naics_code matches code.
  # If no record found chop off the last character of code and try again, and so on.
  def self.find_by_naics_code_and_census_region_number(code, number)
    if code.blank?
      record = nil
    else
      code = Industry.format_naics_code code
      record = where(:census_region_number => number, :naics_code => code).first
      record ||= find_by_naics_code_and_census_region_number(code[0..-2], number)
    end
    record
  end
  
  # TODO make this less paranoid
  # for now only return a ratio if no fuels are nil and at least one fuel is nonzero
  def fuel_ratios
    if energy.to_f > 0 # return nil if energy is nil or 0
      ratios = FUELS.inject({}) do |r, fuel|
        fuel_use = send("#{fuel}")
        r[fuel] = fuel_use.present? ? fuel_use / energy : nil
        r
      end
      ratios unless ratios.values.include? nil or ratios.values.all?(&:zero?) # return nil if any fuel uses were missing or all fuel uses were zero
    end
  end
end
