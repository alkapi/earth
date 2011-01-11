AutomobileTypeFuelAge.class_eval do
  data_miner do
    schema Earth.database_options do
      string  'name'
      string  'type_name'
      string  'fuel_name'
      integer 'age'
      float   'age_percent'
      float   'total_travel_percent'
      float   'annual_distance'
      string  'annual_distance_units'
      integer 'vehicles'
    end
    
    import "age distribution of gasoline passenger cars from the 2010 EPA GHG Inventory",
           :url => 'http://www.epa.gov/climatechange/emissions/downloads10/2010-Inventory-Annex-Tables.zip',
           :filename => 'Annex Tables/Annex 3/Table A-91.csv',
           :skip => 1 do
      key 'name', :synthesize => lambda { |row| "Passenger cars gasoline age #{row['Vehicle Age']}" if row['Vehicle Age'].length < 3 }
      store 'type_name', :static => 'Passenger cars'
      store 'fuel_name', :static => 'Gasoline'
      store 'age', :field_name => 'Vehicle Age'
      store 'age_percent', :synthesize => lambda { |row| row['LDGV'].to_f / 100 }
    end
    
    import "age distribution of gasoline light-duty trucks from the 2010 EPA GHG Inventory",
           :url => 'http://www.epa.gov/climatechange/emissions/downloads10/2010-Inventory-Annex-Tables.zip',
           :filename => 'Annex Tables/Annex 3/Table A-91.csv',
           :skip => 1 do
      key 'name', :synthesize => lambda { |row| "Light-duty trucks gasoline age #{row['Vehicle Age']}" if row['Vehicle Age'].length < 3 }
      store 'type_name', :static => 'Light-duty trucks'
      store 'fuel_name', :static => 'Gasoline'
      store 'age', :field_name => 'Vehicle Age'
      store 'age_percent', :synthesize => lambda { |row| row['LDGT'].to_f / 100 }
    end
    
    import "age distribution of diesel passenger cars from the 2010 EPA GHG Inventory",
           :url => 'http://www.epa.gov/climatechange/emissions/downloads10/2010-Inventory-Annex-Tables.zip',
           :filename => 'Annex Tables/Annex 3/Table A-91.csv',
           :skip => 1 do
      key 'name', :synthesize => lambda { |row| "Passenger cars diesel age #{row['Vehicle Age']}" if row['Vehicle Age'].length < 3 }
      store 'type_name', :static => 'Passenger cars'
      store 'fuel_name', :static => 'Diesel'
      store 'age', :field_name => 'Vehicle Age'
      store 'age_percent', :synthesize => lambda { |row| row['LDDV'].to_f / 100 }
    end
    
    import "age distribution of diesel light-duty trucks from the 2010 EPA GHG Inventory",
           :url => 'http://www.epa.gov/climatechange/emissions/downloads10/2010-Inventory-Annex-Tables.zip',
           :filename => 'Annex Tables/Annex 3/Table A-91.csv',
           :skip => 1 do
      key 'name', :synthesize => lambda { |row| "Light-duty trucks diesel age #{row['Vehicle Age']}" if row['Vehicle Age'].length < 3 }
      store 'type_name', :static => 'Light-duty trucks'
      store 'fuel_name', :static => 'Diesel'
      store 'age', :field_name => 'Vehicle Age'
      store 'age_percent', :synthesize => lambda { |row| row['LDDT'].to_f / 100 }
    end
    
    import "total travel distribution of gasoline passenger cars from the 2010 EPA GHG Inventory",
           :url => 'http://www.epa.gov/climatechange/emissions/downloads10/2010-Inventory-Annex-Tables.zip',
           :filename => 'Annex Tables/Annex 3/Table A-93.csv',
           :skip => 1 do
      key 'name', :synthesize => lambda { |row| "Passenger cars gasoline age #{row['Vehicle Age']}" if row['Vehicle Age'].length < 3 }
      store 'total_travel_percent', :synthesize => lambda { |row| row['LDGV'].to_f / 100 }
    end
    
    import "total travel distribution of gasoline light-duty trucks from the 2010 EPA GHG Inventory",
           :url => 'http://www.epa.gov/climatechange/emissions/downloads10/2010-Inventory-Annex-Tables.zip',
           :filename => 'Annex Tables/Annex 3/Table A-93.csv',
           :skip => 1 do
      key 'name', :synthesize => lambda { |row| "Light-duty trucks gasoline age #{row['Vehicle Age']}" if row['Vehicle Age'].length < 3 }
      store 'total_travel_percent', :synthesize => lambda { |row| row['LDGT'].to_f / 100 }
    end
    
    import "toal travel distribution of diesel passenger cars from the 2010 EPA GHG Inventory",
           :url => 'http://www.epa.gov/climatechange/emissions/downloads10/2010-Inventory-Annex-Tables.zip',
           :filename => 'Annex Tables/Annex 3/Table A-93.csv',
           :skip => 1 do
      key 'name', :synthesize => lambda { |row| "Passenger cars diesel age #{row['Vehicle Age']}" if row['Vehicle Age'].length < 3 }
      store 'total_travel_percent', :synthesize => lambda { |row| row['LDDV'].to_f / 100 }
    end
    
    import "total travel distribution of diesel light-duty trucks from the 2010 EPA GHG Inventory",
           :url => 'http://www.epa.gov/climatechange/emissions/downloads10/2010-Inventory-Annex-Tables.zip',
           :filename => 'Annex Tables/Annex 3/Table A-93.csv',
           :skip => 1 do
      key 'name', :synthesize => lambda { |row| "Light-duty trucks diesel age #{row['Vehicle Age']}" if row['Vehicle Age'].length < 3 }
      store 'total_travel_percent', :synthesize => lambda { |row| row['LDDT'].to_f / 100 }
    end
    
    import "average annual distance for gasoline passenger cars from the 2010 EPA GHG Inventory",
           :url => 'http://www.epa.gov/climatechange/emissions/downloads10/2010-Inventory-Annex-Tables.zip',
           :filename => 'Annex Tables/Annex 3/Table A-92.csv',
           :skip => 1 do
      key 'name', :synthesize => lambda { |row| "Passenger cars gasoline age #{row['Vehicle Age']}" if row['Vehicle Age'].length < 3 }
      store 'annual_distance', :synthesize => lambda { |row| row['LDGV'].to_s.sub(',', '') }, :units => :miles
    end
    
    import "average annual distance for gasoline light-duty trucks from the 2010 EPA GHG Inventory",
           :url => 'http://www.epa.gov/climatechange/emissions/downloads10/2010-Inventory-Annex-Tables.zip',
           :filename => 'Annex Tables/Annex 3/Table A-92.csv',
           :skip => 1 do
      key 'name', :synthesize => lambda { |row| "Light-duty trucks gasoline age #{row['Vehicle Age']}" if row['Vehicle Age'].length < 3 }
      store 'annual_distance', :synthesize => lambda { |row| row['LDGT'].to_s.sub(',', '') }, :units => :miles
    end
    
    import "average annual distance for diesel passenger cars from the 2010 EPA GHG Inventory",
           :url => 'http://www.epa.gov/climatechange/emissions/downloads10/2010-Inventory-Annex-Tables.zip',
           :filename => 'Annex Tables/Annex 3/Table A-92.csv',
           :skip => 1 do
      key 'name', :synthesize => lambda { |row| "Passenger cars diesel age #{row['Vehicle Age']}" if row['Vehicle Age'].length < 3 }
      store 'annual_distance', :synthesize => lambda { |row| row['LDDV'].to_s.sub(',', '') }, :units => :miles
    end
    
    import "average annual distance for diesel light-duty trucks from the 2010 EPA GHG Inventory",
           :url => 'http://www.epa.gov/climatechange/emissions/downloads10/2010-Inventory-Annex-Tables.zip',
           :filename => 'Annex Tables/Annex 3/Table A-92.csv',
           :skip => 1 do
      key 'name', :synthesize => lambda { |row| "Light-duty trucks diesel age #{row['Vehicle Age']}" if row['Vehicle Age'].length < 3 }
      store 'annual_distance', :synthesize => lambda { |row| row['LDDT'].to_s.sub(',', '') }, :units => :miles
    end
    
    process "Convert annual distance from miles to kilometres" do
      conversion_factor = 1.miles.to(:kilometres)
      update_all "annual_distance = annual_distance * #{conversion_factor}"
      update_all "annual_distance_units = 'kilometres'"
    end
    
    process "Calculate number of vehicles from total travel and total travel percent" do
      connection.execute %{
        UPDATE automobile_type_fuel_ages
        SET automobile_type_fuel_ages.vehicles =
          ((SELECT automobile_type_fuel_years.total_travel
          FROM automobile_type_fuel_years
          WHERE automobile_type_fuel_years.year =
          (SELECT max(automobile_type_fuel_years.year) FROM automobile_type_fuel_years)
          AND automobile_type_fuel_years.type_name = automobile_type_fuel_ages.type_name
          AND automobile_type_fuel_years.fuel_name = automobile_type_fuel_ages.fuel_name
          ) * automobile_type_fuel_ages.total_travel_percent / automobile_type_fuel_ages.annual_distance )
      }
    end
    
    verify "Type name and fuel name should never be missing" do
      AutomobileTypeFuelAge.all.each do |record|
        %w{ type_name fuel_name }.each do |attribute|
          value = record.send(:"#{attribute}")
          if value.nil?
            raise "Missing #{attribute} for AutomobileTypeFuelAge '#{record.name}'"
          end
        end
      end
    end
    
    verify "Age should be between zero and thirty" do
      AutomobileTypeFuelAge.all.each do |record|
        value = record.send(:age)
        unless value >= 0 and value < 31
          raise "Invalid age for AutomobileTypeFuelAge '#{record.name}': #{value} (should be between 0 and 30)"
        end
      end
    end
    
    verify "Age and total travel percent should be between zero and one" do
      AutomobileTypeFuelAge.all.each do |record|
        %w{ age_percent total_travel_percent }.each do |attribute|
          percent = record.send(:"#{attribute}")
          unless percent > 0 and percent < 1
            raise "Invalid #{attribute} for AutomobileTypeFuelAge '#{record.name}': #{percent} (should be between 0 and 1)"
          end
        end
      end
    end
    
    verify "Annual distance and vehicles should be greater than zero" do
      AutomobileTypeFuelAge.all.each do |record|
        %w{ annual_distance vehicles }.each do |attribute|
          value = record.send(:"#{attribute}")
          unless value > 0
            raise "Invalid #{attribute} for AutomobileTypeFuelAge '#{record.name}': #{value} (should be > 0)"
          end
        end
      end
    end
    
    verify "Annual distance units should be kilometres" do
      AutomobileTypeFuelAge.all.each do |record|
        units = record.send(:annual_distance_units)
        unless units == "kilometres"
          raise "Invalid annual distance units for AutomobileTypeFuelAge '#{record.name}': #{units} (should be kilometres)"
        end
      end
    end
  end
end
