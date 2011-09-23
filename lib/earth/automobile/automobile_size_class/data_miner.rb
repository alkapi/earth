AutomobileSizeClass.class_eval do
  data_miner do
    # FIXME TODO pull this from AutomobileSizeClassYear
    import "a list of size classes and pre-calculated fuel efficiencies",
           :url => 'https://spreadsheets.google.com/pub?key=0AoQJbWqPrREqdHlRUE5IcWlrRENhN0EtUldPTy1rX1E&gid=0&output=csv' do
      key 'name'
      store 'type_name'
      store 'fuel_efficiency_city', :units_field_name => 'fuel_efficiency_city_units'
      store 'fuel_efficiency_highway', :units_field_name => 'fuel_efficiency_highway_units'
    end
    
    process "Ensure AutomobileTypeFuelYearAge is populated" do
      AutomobileTypeFuelYearAge.run_data_miner!
    end
    
    # FIXME TODO make this a method on AutomobileSizeClass?
    process "Calculate annual distance from AutomobileTypeFuelYearAge" do
      ages = AutomobileTypeFuelYearAge.arel_table
      classes = AutomobileSizeClass.arel_table
      conditional_relation = ages[:type_name].eq(classes[:type_name])
      update_all "annual_distance = (#{AutomobileTypeFuelYearAge.weighted_average_relation(:annual_distance, :weighted_by => :vehicles).where(conditional_relation).to_sql})"
      update_all "annual_distance_units = 'kilometres'"
    end
    
    import "pre-calculated fuel efficiency multipliers",
           :url => 'https://spreadsheets.google.com/pub?key=0AoQJbWqPrREqdGt2NnhXLXUxNFRJSzczU3BkSHB3enc&hl=en&gid=0&output=csv' do
      key 'name'
      store 'hybrid_fuel_efficiency_city_multiplier'
      store 'hybrid_fuel_efficiency_highway_multiplier'
      store 'conventional_fuel_efficiency_city_multiplier'
      store 'conventional_fuel_efficiency_highway_multiplier'
    end
  end
end
