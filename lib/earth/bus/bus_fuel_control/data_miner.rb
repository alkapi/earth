BusFuelControl.class_eval do
  data_miner do
    schema Earth.database_options do
      string 'name'
      string 'bus_fuel_name'
      string 'control'
      float  'ch4_emission_factor'
      string 'ch4_emission_factor_units'
      float  'n2o_emission_factor'
      string 'n2o_emission_factor_units'
    end
    
    import "a list of bus fuel controls",
           :url => 'https://spreadsheets.google.com/pub?key=0AoQJbWqPrREqdEw1QW80VVJhaXRkUURQSFhHczNyVWc&output=csv' do
      key   'name'
      store 'bus_fuel_name'
      store 'control'
      store 'ch4_emission_factor', :units_field_name => 'ch4_emission_factor_units'
      store 'n2o_emission_factor', :units_field_name => 'n2o_emission_factor_units'
    end
    
    process "Convert emission factors to metric units" do
      conversion_factor = (1 / 1.609344) * (1.0 / 1_000.0 ) # Google: 1 mile / 1.609344 km * 1 kg / 1000 g
      connection.execute %{
        UPDATE bus_fuel_controls
        SET ch4_emission_factor = ch4_emission_factor * #{conversion_factor},
            ch4_emission_factor_units = 'kilograms_per_kilometre'
        WHERE ch4_emission_factor_units = 'grams_per_mile'
      }
      
      connection.execute %{
        UPDATE bus_fuel_controls
        SET n2o_emission_factor = n2o_emission_factor * #{conversion_factor},
            n2o_emission_factor_units = 'kilograms_per_kilometre'
        WHERE n2o_emission_factor_units = 'grams_per_mile'
      }
    end
    
    # FIXME TODO verify this
  end
end
