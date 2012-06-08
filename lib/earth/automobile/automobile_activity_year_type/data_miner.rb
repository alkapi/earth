AutomobileActivityYearType.class_eval do
  data_miner do
    process "Start from scratch" do
      delete_all
    end
    
    import "annual automobile air conditioning emissions derived from the 2010 EPA GHG Inventory",
           :url => "file://#{Earth::DATA_DIR}/automobile/hfc_emissions.csv" do
      key   'name'
      store 'activity_year'
      store 'type_name'
      store 'hfc_emissions', :from_units => :teragrams_co2e, :to_units => :kilograms_co2e
    end
    
    process "Ensure AutomobileActivityYearTypeFuel is populated" do
      AutomobileActivityYearTypeFuel.run_data_miner!
    end
    
    process "Derive hfc emission factor from AutomobileActivityYearTypeFuel" do
      find_each do |aytf|
        aytf.hfc_emission_factor = aytf.hfc_emissions / aytf.activity_year_type_fuels.sum(:distance)
        aytf.hfc_emission_factor_units = aytf.hfc_emissions_units + '_per_' + aytf.activity_year_type_fuels.first.distance_units.singularize
        aytf.save!
      end
    end
  end
end
