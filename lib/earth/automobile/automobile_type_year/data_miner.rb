AutomobileTypeYear.class_eval do
  data_miner do
    import "automobile type year air conditioning emissions derived from the 2010 EPA GHG Inventory",
           :url => 'https://spreadsheets.google.com/pub?key=0AoQJbWqPrREqdFoyTWhDeHpndTV5Ny1aX0sxR1ljSFE&hl=en&gid=0&output=csv' do
      key   'name'
      store 'type_name'
      store 'year'
      store 'hfc_emissions', :units_field_name => 'hfc_emissions_units'
    end
    
    process "Ensure AutomobileTypeFuelYear is populated" do
      AutomobileTypeFuelYear.run_data_miner!
    end
    
    process "Calculate HFC emission factor from AutomobileTypeFuelYear" do
      AutomobileTypeYear.all.each do |record|
        record.hfc_emission_factor = record.hfc_emissions / record.type_fuel_years.sum('fuel_consumption')
        record.hfc_emission_factor_units = "kilograms_co2e_per_litre"
        record.save
      end
    end
    
    verify "Type name should never be missing" do
      AutomobileTypeYear.all.each do |record|
        value = record.send(:type_name)
        unless value.present?
          raise "Missing type name for AutomobileTypeYear '#{record.name}'"
        end
      end
    end
    
    verify "Year should be from 1990 to 2008" do
      AutomobileTypeYear.all.each do |record|
        year = record.send(:year)
        unless year > 1989 and year < 2009
          raise "Invalid year for AutomobileTypeYear '#{record.name}': #{year} (should be from 1990 to 2008)"
        end
      end
    end
    
    %w{ hfc_emissions hfc_emission_factor }.each do |attribute|
      verify "#{attribute.humanize} should be zero or more" do
        AutomobileTypeYear.all.each do |record|
          value = record.send(:"#{attribute}")
          unless value >= 0
            raise "Invalid #{attribute.humanize.downcase} for AutomobileTypeYear '#{record.name}': #{value} (should be zero or more)"
          end
        end
      end
    end
    
    [["hfc_emissions_units", "kilograms_co2e"], ["hfc_emission_factor_units", "kilograms_co2e_per_litre"]].each do |pair|
      attribute = pair[0]
      proper_units = pair[1]
      verify "#{attribute.humanize} should be #{proper_units.humanize.downcase}" do
        AutomobileTypeYear.all.each do |record|
          units = record.send(:"#{attribute}")
          unless units == proper_units
            raise "Invalid #{attribute.humanize.downcase} for AutomobileTypeYear '#{record.name}': #{units} (should be #{proper_units})"
          end
        end
      end
    end
  end
end
